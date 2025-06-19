# Frontiers Harvard Format for Quarto

This is a Quarto extension that provides a template for creating manuscripts formatted according to Frontiers journal requirements using the Harvard (Author-Date) citation style.

## Installation

To use this template in a new project:

```bash
quarto use template urschalupnygrunder/frontiers-harvard
```

To add this format to an existing project:

```bash
quarto add urschalupnygrunder/frontiers-harvard
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

## Changelog

### Version 1.1.0
- Added clickable DOI links in PDF output
- Improved bibliography formatting to match Frontiers CSL style
- Fixed volume and page number formatting
- Removed unwanted citation key display
- Enhanced hyperlink support

### Version 1.0.0
- Initial release with basic Frontiers Harvard formatting