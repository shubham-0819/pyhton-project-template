#!/bin/bash

set -e

echo "Welcome to Python Package Initializer!"
echo "This script will help you set up a basic Python package structure with a virtual environment."
echo

# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to handle errors
handle_error() {
    echo "Error: $1"
    exit 1
}

# Check for required dependencies
dependencies=("python3" "pip" "git" "tree" "virtualenvwrapper")
missing_deps=()

for dep in "${dependencies[@]}"; do
    if ! command_exists "$dep"; then
        missing_deps+=("$dep")
    fi
done

if [ ${#missing_deps[@]} -ne 0 ]; then
    echo "The following required tools are missing:"
    for dep in "${missing_deps[@]}"; do
        echo "- $dep"
    done
    echo
    echo "Please install the missing tools before running this script."
    echo "You can typically install them using your system's package manager."
    echo
    echo "For virtualenvwrapper, you can install it using pip:"
    echo "pip install virtualenvwrapper"
    echo
    echo "After installation, make sure to set up virtualenvwrapper in your shell startup file."
    echo "Please install the missing dependencies and run the script again."
    exit 1
fi

echo "All required dependencies are installed. Proceeding with package initialization."
echo

# Source virtualenvwrapper
source $(which virtualenvwrapper.sh)


# Rest of the script continues here...
# Prompt for package details
read -p "Package name: " package_name
read -p "Version (default: 0.0.1): " version
version=${version:-0.0.1}
read -p "Author name: " author_name
read -p "Author email: " author_email
read -p "Short description: " description
read -p "GitHub username: " github_username

# Create directory structure
mkdir -p "$package_name/src/$package_name" "$package_name/tests" || handle_error "Failed to create directory structure"

# Navigate to the package directory
cd "$package_name" || handle_error "Failed to navigate to package directory"

# Create and activate virtual environment
mkvirtualenv "$package_name" || handle_error "Failed to create virtual environment"


# Upgrade pip and install necessary packages
pip install --upgrade pip || handle_error "Failed to upgrade pip"
pip install pytest build twine || handle_error "Failed to install development dependencies"

# Create __init__.py
cat > "src/$package_name/__init__.py" << EOL || handle_error "Failed to create __init__.py"
from .main import hello_world
EOL

# Create main.py with hello_world function
cat > "src/$package_name/main.py" << EOL || handle_error "Failed to create main.py"
def hello_world():
    return "Hello, World!"

if __name__ == "__main__":
    print(hello_world())
EOL

# Create test_main.py
cat > "tests/test_main.py" << EOL || handle_error "Failed to create test_main.py"
import pytest
from $package_name import hello_world

def test_hello_world():
    assert hello_world() == "Hello, World!"
EOL

# Create README.md
cat > "README.md" << EOL || handle_error "Failed to create README.md"
# $package_name

$description

## Installation

You can install $package_name using pip:

\`\`\`
pip install $package_name
\`\`\`

## Usage

Here's a simple example of how to use $package_name:

\`\`\`python
from $package_name import hello_world

print(hello_world())
\`\`\`

## Development

To set up the development environment:

1. Ensure you have Python 3.7+ installed
2. Clone this repository
3. Navigate to the project directory
4. Activate the virtual environment:
   \`source venv/bin/activate\` (Unix/MacOS) or \`venv\\Scripts\\activate\` (Windows)
5. Install development dependencies: \`pip install -r requirements.txt\`

To run tests:
\`\`\`
pytest
\`\`\`

## License

This project is licensed under the MIT License.
EOL

# Create LICENSE (MIT License)
cat > "LICENSE" << EOL || handle_error "Failed to create LICENSE"
MIT License

Copyright (c) $(date +%Y) $author_name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOL

# Create pyproject.toml
cat > "pyproject.toml" << EOL || handle_error "Failed to create pyproject.toml"
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "$package_name"
version = "$version"
authors = [
  { name="$author_name", email="$author_email" },
]
description = "$description"
readme = "README.md"
requires-python = ">=3.7"
classifiers = [
    "Programming Language :: Python :: 3",
    "License :: OSI Approved :: MIT License",
    "Operating System :: OS Independent",
]

[project.urls]
"Homepage" = "https://github.com/$github_username/$package_name"
"Bug Tracker" = "https://github.com/$github_username/$package_name/issues"
EOL

# Create .gitignore
cat > ".gitignore" << EOL || handle_error "Failed to create .gitignore"
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
dist/
build/
*.egg-info/

# Virtual environments
venv/
env/

# IDE-specific files
.vscode/
.idea/

# Miscellaneous
*.log
.DS_Store
EOL

# Create requirements.txt
cat > "requirements.txt" << EOL || handle_error "Failed to create requirements.txt"
pytest
build
twine
EOL

echo
echo "Python package '$package_name' has been initialized successfully!"
echo "Virtual environment has been created and activated."
echo "Development dependencies have been installed."
echo
echo "Directory structure:"
tree -L 2
echo
echo "A simple 'Hello, World!' application has been created in src/$package_name/main.py"
echo "To run it, use the following command:"
echo "python src/$package_name/main.py"
echo
echo "To run tests, use:"
echo "pytest"
echo
echo "To build your package, use:"
echo "python -m build"
echo
echo "When ready to publish, use:"
echo "twine upload dist/*"
echo
echo "Happy coding!"
