# Markdown to PDF Converter (Direct PDF Approach)

This approach uses mermaid-cli directly to convert Markdown files with Mermaid diagrams into PDF documents. It's a simpler, two-step process that generates PDF diagrams directly without intermediate image formats.

## Prerequisites

1. **Node.js and npm** - [Download from nodejs.org](https://nodejs.org/)
2. **Mermaid CLI** - For converting Mermaid diagrams
   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```
3. **Pandoc** - For converting markdown to PDF
4. **LaTeX** - Required by Pandoc for PDF generation

For detailed installation instructions for each dependency, see the root README.md.

## Usage

The conversion process involves two simple steps:

### 1. Convert Mermaid Diagrams to PDFs

```bash
mmdc -i input.md --outputFormat=pdf --pdfFit -o output_preprocessed.md
```

This command:
- Reads your input markdown file
- Converts all Mermaid diagrams to PDF files
- Generates a preprocessed markdown file with PDF references

### 2. Generate Final PDF

```bash
pandoc output_preprocessed.md -f markdown-implicit_figures -o final_output.pdf
```

This command:
- Converts the preprocessed markdown to PDF
- Properly handles the PDF diagram references
- Generates the final PDF document

## Example Usage

For a file named `document.md`:

```bash
# Step 1: Convert Mermaid diagrams to PDFs
mmdc -i document.md --outputFormat=pdf --pdfFit -o document_preprocessed.md

# Step 2: Generate final PDF
pandoc document_preprocessed.md -f markdown-implicit_figures -o document.pdf

# Optional: Clean up intermediate files
rm document_preprocessed.md document_preprocessed-*.pdf
```

## Pros and Cons

### Advantages
- Simpler, more straightforward process
- Uses direct PDF conversion for diagrams (better quality)
- No custom script maintenance required
- Vector-based diagrams scale better
- Fewer conversion steps

### Disadvantages
- Less detailed progress feedback
- Manual cleanup of intermediate files
- Less control over the conversion process
- Fixed naming convention for intermediate files

## Troubleshooting

1. **If mermaid-cli is not found**
   - Verify Node.js and npm installation
   - Try using the full path to mmdc

2. **If PDF images are not found**
   - Ensure you're in the correct directory
   - Check that PDF files were generated
   - Verify image paths in preprocessed markdown

3. **If pandoc fails**
   - Verify pandoc installation
   - Use --verbose flag for more information
   ```bash
   pandoc --verbose input.md -o output.pdf
   ``` 