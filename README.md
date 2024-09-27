# Python Package Initializer

Welcome to the **Python Package Initializer**! This script helps you quickly set up a basic Python package structure with a virtual environment. It handles the creation of directory structures, files, and even sets up a virtual environment with essential development dependencies.

## Features

- Creates a basic Python package structure with `src`, `tests`, and more.
- Sets up a virtual environment using `virtualenvwrapper`.
- Installs development dependencies: `pytest`, `build`, and `twine`.
- Creates essential files like `README.md`, `LICENSE`, `pyproject.toml`, and `.gitignore`.
- Generates simple `Hello, World!` code to start with.
- Automates the entire setup, reducing manual work.

## Prerequisites

Make sure you have the following dependencies installed before running the script:

- `python3`
- `pip`
- `git`
- `tree` (for displaying directory structure)
- `virtualenvwrapper`

You can install `virtualenvwrapper` with pip if you don’t have it:

```bash
pip install virtualenvwrapper
```

After installation, make sure to configure `virtualenvwrapper` in your shell startup file.

## Usage

1. Clone the repository or download the script directly:

    ```bash
    git clone https://github.com/shubham-0819/pyhton-project-template.git
    cd pyhton-project-template
    chmod +x init-python-package.sh
    ```

2. Run the script:

    ```bash
    ./init-python-package.sh
    ```

3. Follow the prompts to input the package name, author details, and other relevant information.

## Script Output

After running the script, you will have a complete package structure with the following directories and files:

- `src/`: Contains your package’s source code.
- `tests/`: Contains test cases for your package.
- `README.md`: A markdown file describing your project.
- `LICENSE`: A default MIT license.
- `pyproject.toml`: A project file to support modern Python builds.
- `.gitignore`: A list of files to be ignored by Git.

## Example Directory Structure

```bash
your-package/
├── LICENSE
├── README.md
├── pyproject.toml
├── requirements.txt
├── src/
│   └── your-package/
│       ├── __init__.py
│       └── main.py
├── tests/
│   └── test_main.py
└── .gitignore
```

## Running the Project

To run the `Hello, World!` example provided by the script:

```bash
python src/your-package/main.py
```

## Running Tests

To run the test cases using `pytest`:

```bash
pytest
```

## Building the Package

When you are ready to build your package, use the following command:

```bash
python -m build
```

This will generate distribution files in the `dist/` directory.

## Publishing the Package

To publish your package on PyPI using `twine`:

```bash
twine upload dist/*
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---
