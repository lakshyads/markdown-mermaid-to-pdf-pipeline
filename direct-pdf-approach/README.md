# Markdown to PDF Converter (Direct PDF Approach)

This approach uses mermaid-cli directly to convert Markdown files with Mermaid diagrams into PDF documents. It's a simple, two-step process that generates PDF diagrams directly without intermediate image formats.

## Prerequisites

1. **Node.js and npm** - [Download from nodejs.org](https://nodejs.org/)
2. **Mermaid CLI** - For converting Mermaid diagrams

   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

3. **Pandoc** - For converting markdown to PDF

For detailed installation instructions for each dependency, see the root README.md.

## Usage

You can use the provided shell script that handles the conversion process:

```bash
./mermaid-to-pdf.sh input.md [output.pdf]
```

The script accepts two arguments:

- `input.md`: Your markdown file containing Mermaid diagrams (required)
- `output.pdf`: The desired output PDF filename (optional, defaults to input filename with .pdf extension)

### Examples

1. Basic usage (output will be `document.pdf`):

   ```bash
   ./mermaid-to-pdf.sh document.md
   ```

2. Specify custom output filename:

   ```bash
   ./mermaid-to-pdf.sh input.md custom-output.pdf
   ```

3. Show help:

   ```bash
   ./mermaid-to-pdf.sh --help
   ```

### Features

- Flexible input/output naming
- Automatic cleanup of temporary files
- Hidden temporary directory (`.temp_*`)
- Progress feedback
- Enhanced error handling and troubleshooting
- Automatic detection of mermaid-cli installation
- Platform-specific installation instructions
- PDF file count verification
- Help documentation

## How It Works

The script performs these steps:

1. Creates a hidden temporary directory
2. Detects and verifies mermaid-cli installation
3. Converts Mermaid diagrams to PDFs using mermaid-cli
4. Moves generated PDFs to the temporary directory
5. Generates a preprocessed markdown file with correct PDF references
6. Uses Pandoc to create the final PDF
7. Verifies the number of generated PDFs
8. Automatically cleans up all temporary files

## Example Markdown File

```markdown
# My Document

Here's a flowchart:

    ```mermaid
    graph TD
        A[Start] --> B{Is it working?}
        B -- Yes --> C[Great!]
        B -- No --> D[Debug]
        D --> B
    ```
```

## Troubleshooting

1. **If mermaid-cli is not found**
   - The script will automatically search for mmdc in:
     - Global npm installation directory
     - Node version manager paths (nvm, asdf, nodenv)
   - If not found, follow the installation instructions:
     ```bash
     npm install -g @mermaid-js/mermaid-cli
     ```

2. **If PDF images are not found**
   - The script now verifies PDF generation and counts
   - Check the script output for any error messages
   - Verify that the input file exists and is readable
   - Ensure you have write permissions in the output directory

3. **If pandoc fails**
   - The script checks for pandoc installation
   - Platform-specific installation instructions are provided:
     - macOS: `brew install pandoc`
     - Linux: `sudo apt-get install pandoc`
     - Windows: Download from [pandoc.org](https://pandoc.org/installing.html)

4. **[@zenuml/core] warnings**
   - These are informational messages from the Mermaid CLI
   - They don't affect the functionality of the generated PDF
   - Can be safely ignored

## Manual Approach

If you prefer to run the commands manually:

```bash
# Step 1: Convert Mermaid diagrams to PDFs
mmdc -i input.md --outputFormat=pdf --pdfFit -o preprocessed.md

# Step 2: Generate final PDF
pandoc preprocessed.md -f markdown-implicit_figures -o output.pdf

# Optional: Clean up
rm preprocessed.md preprocessed-*.pdf
```
