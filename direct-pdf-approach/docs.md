# Generating PDFs from Markdown with Mermaid Diagrams

This guide explains how to convert Markdown files containing Mermaid diagrams into PDF documents. The process involves two main steps: converting Mermaid diagrams to PDFs and then combining them with the rest of the markdown content.

## Prerequisites

1. **Node.js and npm**
   - Required for installing and running mermaid-cli
   - Install from [nodejs.org](https://nodejs.org/)

2. **Pandoc**
   - Required for converting markdown to PDF
   - On macOS, install using Homebrew:

     ```bash
     brew install pandoc
     ```

3. **Required npm packages**

   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

## Step-by-Step Process

### 1. Convert Mermaid Diagrams to PDFs

First, use mermaid-cli to convert all Mermaid diagrams in your markdown file to PDFs:

```bash
mmdc -i input.md --outputFormat=pdf --pdfFit -o output_preprocessed.md
```

This command will:

- Read your input markdown file (`input.md`)
- Convert all Mermaid diagrams to PDF files
- Generate a new markdown file (`output_preprocessed.md`) with references to the PDF files
- The PDF files will be generated in the same directory as the markdown file

### 2. Convert to Final PDF

Use pandoc to convert the preprocessed markdown to a final PDF:

```bash
cd docs && pandoc output_preprocessed.md -f markdown-implicit_figures -o final_output.pdf
```

This command will:

- Change to the directory containing the markdown file and PDFs
- Convert the preprocessed markdown to PDF
- Use the `markdown-implicit_figures` format to properly handle the PDF images
- Generate the final PDF file

## Example

Here's a complete example using a file named `TECHNICAL_AUDIT_REPORT.md`:

```bash
# Convert Mermaid diagrams to PDFs
mmdc -i docs/TECHNICAL_AUDIT_REPORT.md --outputFormat=pdf --pdfFit -o docs/TECHNICAL_AUDIT_REPORT_preprocessed.md

# Convert to final PDF
cd docs && pandoc TECHNICAL_AUDIT_REPORT_preprocessed.md -f markdown-implicit_figures -o TECHNICAL_AUDIT_REPORT.pdf
```

## Cleanup

After generating the final PDF, you can remove all intermediate files:

```bash
# Remove the preprocessed markdown file
rm docs/TECHNICAL_AUDIT_REPORT_preprocessed.md

# Remove all intermediate PDF files
rm docs/TECHNICAL_AUDIT_REPORT_preprocessed-*.pdf
```

After cleanup, you should have only:
- Original markdown file: `docs/TECHNICAL_AUDIT_REPORT.md`
- Final PDF file: `docs/TECHNICAL_AUDIT_REPORT.pdf`

## Troubleshooting

1. **If mermaid-cli is not found**
   - Make sure Node.js and npm are properly installed
   - Try using the full path to mmdc:

     ```bash
     /Users/username/.asdf/installs/nodejs/version/bin/mmdc
     ```

2. **If PDF images are not found**
   - Make sure you're in the correct directory when running pandoc
   - Verify that the PDF files were generated in the same directory as the markdown file
   - Check that the image paths in the preprocessed markdown file are correct

3. **If pandoc fails to generate PDF**
   - Make sure pandoc is installed correctly
   - Try using the `--verbose` flag to get more information:

     ```bash
     pandoc --verbose input.md -o output.pdf
     ```

## Best Practices

1. **File Organization**
   - Keep all related files (markdown, PDFs) in the same directory
   - Use relative paths for image references

2. **Mermaid Syntax**
   - Ensure your Mermaid diagrams use valid syntax
   - Test diagrams individually before converting the entire document

3. **PDF Generation**
   - Always verify the generated PDF for:
     - Correct diagram rendering
     - Proper formatting
     - Image placement and quality

## Additional Resources

- [Mermaid Documentation](https://mermaid.js.org/)
- [Pandoc Documentation](https://pandoc.org/MANUAL.html)
- [mermaid-cli GitHub Repository](https://github.com/mermaid-js/mermaid-cli)
