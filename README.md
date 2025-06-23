# Frontiers Harvard Format for Quarto

This is a Quarto extension that provides a template for creating manuscripts formatted according to Frontiers journal requirements using the Harvard (Author-Date) citation style.

## Installation

### From GitHub (Recommended)

To use this template in a new project:

```bash
quarto use template Theurrien/frontiers_quarto_extension
```

To add this format to an existing project:

```bash
quarto add Theurrien/frontiers_quarto_extension
```

### From Local Files

If you've cloned or downloaded this repository to your local machine:

1. **Clone or download** this repository to your computer
2. **Navigate to your Quarto project** directory in the terminal
3. **Install the extension** from the local path:

```bash
quarto add /path/to/frontiers_quarto_extension
```

For example, if you downloaded the extension to your Downloads folder:
```bash
quarto add ~/Downloads/frontiers_quarto_extension
```

Or if you cloned it to a specific directory:
```bash
quarto add /Users/yourusername/GitHub_Repos/frontiers_quarto_extension
```

**Alternative local installation:**
You can also copy the entire extension folder to your project's `_extensions` directory:

1. Create an `_extensions` folder in your Quarto project (if it doesn't exist)
2. Copy the entire `frontiers_quarto_extension` folder into `_extensions/`
3. Rename it to `frontiers-harvard` for consistency:
```
your-project/
├── _extensions/
│   └── frontiers-harvard/
│       ├── _extension.yml
│       ├── Frontiers-Harvard.bst
│       └── ... (all other files)
├── your-document.qmd
└── references.bib
```

## Usage

After installation, you can use the format by specifying it in your document's YAML header:

```yaml
format:
  frontiers-harvard-pdf:
    keep-tex: true
```

## Features

- Full support for Frontiers journal formatting requirements
- Harvard (Author-Date) citation style with improved bibliography formatting
- **Clickable DOI links** in PDF output that open DOI URLs when clicked
- **CSL-compatible formatting** with volume and pages properly separated
- Automatic handling of author affiliations and corresponding author information
- Support for all required Frontiers sections (Conflict of Interest, Author Contributions, etc.)
- Line numbering for review process
- Proper logo placement and formatting
- Clean bibliography output without citation keys or annotations

## Requirements

- Quarto version 1.6.0 or higher
- LaTeX distribution with required packages (including hyperref for clickable links)
- The `logo1.eps` or `logo1.pdf` file must be present for proper header rendering

## Bibliography Format

The bibliography now follows the Frontiers CSL style with:
- Authors in "Last, F." format
- Year in parentheses after authors
- Journal names italicized
- Volume and pages separated by comma (e.g., "Volume 10, e3360")
- Clickable DOI links formatted as "doi: 10.1002/example" that link to https://doi.org/...

## Development and Contribution

This extension includes custom enhancements to improve bibliography formatting and add clickable DOI functionality. For developers interested in contributing or understanding the technical implementation:

- **CLAUDE.md**: Contains detailed technical documentation for AI-assisted development
- **Custom BST file**: The `Frontiers-Harvard.bst` file has been modified with enhanced functions for DOI linking and CSL-compatible formatting
- **Testing**: Use the included `frontiers-template.qmd` and `references.bib` for testing changes

When making modifications, always clear bibliography cache files (`.aux`, `.bbl`, `.blg`) before testing to ensure changes take effect.

## Changelog

v1.0.0: Basic Frontiers formatting
v1.1.0: Enhanced with clickable DOIs and CSL-compatible formatting
v1.2.0: Complete note field suppression for Zotero compatibility and misc entry improvements
v1.3.0: Fixed subfigure captions to generate proper (A), (B), (C) labels instead of descriptive text
v1.4.0: Added native DOCX format support with Frontiers styling and proper image embedding
v1.5.0: Added automatic citation sorting filter for proper alphabetical ordering of multiple citations
v1.5.1: Fixed level 4 heading (paragraph) spacing to use run-in style without extra line breaks
