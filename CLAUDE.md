# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Quarto extension that provides Frontiers journal formatting with Harvard (Author-Date) citation style. The extension has been enhanced from the original template to include clickable DOI links and improved bibliography formatting that matches Frontiers CSL style.

## Key Components

### Core Extension Files
- `_extension.yml` - Main configuration defining the PDF format and LaTeX packages
- `Frontiers-Harvard.bst` - **Modified bibliography style file** with custom improvements
- `FrontiersinHarvard.cls` - LaTeX document class for Frontiers formatting
- `template.tex` - Main LaTeX template structure

### Bibliography Enhancement Architecture
The bibliography system has been significantly customized:

1. **BST File Modifications**: The `Frontiers-Harvard.bst` file contains several custom functions:
   - `format.vol.num.pages` - Modified to output "volume, pages" format instead of just volume
   - `format.doi` - Changed to create clickable hyperlinks using `\href{https://doi.org/...}{...}`
   - `article` function - Removed `format.note output` to prevent citation key display
   - `fin.entry` - Removed annotation functionality that was outputting unwanted citation keys

2. **Hyperlink Integration**: The extension uses LaTeX's `hyperref` package (defined in `_extension.yml`) to enable clickable DOI links in PDF output.

3. **Note Field Handling**: Bibliography entries with `note = {Citation Key: ...}` fields are filtered out at the BST level to prevent display in final output.

## Testing and Development Commands

### Testing the Extension
To test modifications to the extension:

```bash
# Install extension locally for testing
quarto add /path/to/this/extension

# Render a test document
quarto render frontiers-template.qmd --to frontiers-harvard-pdf

# Force bibliography regeneration (delete auxiliary files first)
rm *.aux *.bbl *.blg 2>/dev/null
quarto render frontiers-template.qmd --to frontiers-harvard-pdf
```

### Bibliography Development Workflow
When modifying bibliography formatting:

1. **Edit the BST file**: Make changes to `Frontiers-Harvard.bst`
2. **Clear cache**: Delete `.aux`, `.bbl`, and `.blg` files to force BibTeX regeneration
3. **Test render**: Use the provided `frontiers-template.qmd` with `references.bib`
4. **Check output**: Verify DOI links are clickable and format matches expectations

### Version Management
Update version in `_extension.yml` when making significant changes. Current architecture supports:
- v1.0.0: Basic Frontiers formatting
- v1.1.0: Enhanced with clickable DOIs and CSL-compatible formatting
- v1.2.0: Complete note field suppression for Zotero compatibility and misc entry improvements
- v1.3.0: Fixed subfigure captions to generate proper (A), (B), (C) labels instead of descriptive text
- v1.4.0: Added native DOCX format support with Frontiers styling and proper image embedding
- v1.5.0: Added automatic citation sorting filter for proper alphabetical ordering of multiple citations
- v1.5.1: Fixed level 4 heading (paragraph) spacing to use run-in style without extra line breaks

## Important Technical Details

### Bibliography Style Customizations
- **DOI Links**: Use `\href{https://doi.org/...}{...}` format, not `\doi{...}` command
- **Volume/Pages**: Combined in single function with comma separator
- **Note Filtering**: ALL entry type functions exclude note field output to prevent Zotero citation key display
- **Annotation Removal**: All `\bibAnnote` functionality removed from BST
- **Misc Entry Type**: Removed hardcoded "[Dataset]" prefix to handle R packages, software, and other misc items properly

### File Dependencies
- `logo1.eps` or `logo1.pdf` must be present for header rendering
- LaTeX packages: hyperref, url, lineno, microtype, multirow, setspace, amssymb, etoolbox
- Requires pdflatex engine and natbib citation method

### Extension Installation Paths
The extension supports multiple installation methods:
- GitHub: `quarto add urschalupnygrunder/frontiers_quarto_extension`
- Local: `quarto add /path/to/extension`
- Manual: Copy to `_extensions/frontiers-harvard/` in project

### Subfigure Caption Fix (v1.3.0)
The extension now properly handles Quarto subfigures by implementing a custom `\subcaption` command that generates automatic (A), (B), (C) labels instead of using the alt-text from images. This resolves conflicts between Quarto's caption package and the Frontiers class's built-in subfigure support.

**Technical Implementation:**
- Custom `pandocsubfig` counter for automatic lettering
- Counter resets at the beginning of each figure environment
- Generates `(A)`, `(B)`, `(C)` labels automatically
- Compatible with Frontiers class's existing figure numbering

## Common Issues and Solutions

### Bibliography Problems
- **Citation keys appearing**: This has been resolved - all entry type functions now exclude note field output
- **DOI not clickable**: Verify `\href` format in `format.doi` function and hyperref package inclusion
- **Wrong formatting**: Clear auxiliary files and regenerate bibliography

### Subfigure Caption Issues
- **Descriptive text instead of (A), (B), (C)**: Fixed in v1.3.0 with custom subcaption implementation
- **Subcaptions not appearing**: Ensure etoolbox package is available and figure environment is properly structured
- **Wrong numbering sequence**: Counter automatically resets at each figure environment

### Entry Type Function Modifications (v1.2.0)
All entry type functions have been modified to exclude note field output to prevent Zotero citation keys from appearing in the final bibliography:

- **article**: Already excluded notes (unchanged)
- **book**: Removed `format.note output`
- **booklet**: Removed `format.note output`
- **inbook**: Removed `format.note output`
- **incollection**: Removed `format.note output`
- **inproceedings**: Removed `format.note output`
- **manual**: Removed `format.note output`
- **mastersthesis**: Removed `format.note output`
- **misc**: Removed `format.note output` and hardcoded "[Dataset]" prefix
- **phdthesis**: Removed `format.note output`
- **proceedings**: Removed `format.note output`
- **techreport**: Removed `format.note output`
- **unpublished**: Removed `format.note "note" output.check` (was required field)

### Citation Sorting (v1.5.0)

The extension includes automatic citation sorting for proper academic formatting:

**Citation Sort Filter (`citation-sort.lua`):**
- Automatically sorts multiple citations alphabetically by citation key
- Processes citations during Pandoc conversion phase
- Case-insensitive comparison for consistent ordering
- Follows Chicago/Harvard style conventions

**Examples:**
- Input: `[@liu2023; @johnson2023]`
- Output: `(Johnson-Glenberg et al., 2023; Liu et al., 2023)`

### LaTeX Compilation Issues
- **Missing logo**: Ensure `logo1.eps` or `logo1.pdf` is present
- **Package errors**: Check that all required LaTeX packages are installed
- **Font issues**: Extension uses standard LaTeX fonts with specific formatting commands

### Citation Sorting Issues
- **Wrong order**: The `citation-sort.lua` filter automatically handles alphabetical sorting
- **Filter not working**: Ensure filter is listed in `_extension.yml` under `common.filters`
- **Custom sorting needed**: Modify the `compare_citations` function in `citation-sort.lua`

### Heading Spacing Issues (v1.5.1)
- **Level 4 headings with extra spacing**: Fixed in v1.5.1 - paragraph headings now use run-in style
- **Text not continuing on same line**: The spacing parameter was changed from `{1\p@}` to `{-1em}` in the `\paragraph` definition
- **Custom heading spacing needed**: Modify the spacing parameters in the `\@startsection` calls in `FrontiersinHarvard.cls`