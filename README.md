# Markdown to PDF with Mermaid Converter

A Node.js script that converts Markdown files containing Mermaid diagrams into PDF documents. The script automatically processes Mermaid diagram code blocks, converts them to images, and includes them in the final PDF output.

## Features

- Converts Markdown files to PDF while preserving Mermaid diagrams
- Automatically processes multiple Mermaid diagrams in a single document
- Supports custom output filenames
- Provides detailed progress feedback
- Cleans up temporary files automatically
- Handles errors gracefully

## Prerequisites

Before using this tool, make sure you have the following installed:

1. **Node.js and npm** - [Download from nodejs.org](https://nodejs.org/)

   ```bash
   # Verify installation
   node --version
   npm --version
   ```

2. **Mermaid CLI** - For converting Mermaid diagrams to images

   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

3. **Pandoc** - For converting Markdown to PDF
   - On macOS (using Homebrew):

     ```bash
     brew install pandoc
     ```

   - On Linux:

     ```bash
     sudo apt-get install pandoc
     ```

   - On Windows:
     Download from [pandoc.org](https://pandoc.org/installing.html)

4. **LaTeX** - Required by Pandoc for PDF generation
   - On macOS:

     ```bash
     brew install --cask mactex
     ```

   - On Linux:

     ```bash
     sudo apt-get install texlive-xetex
     ```

   - On Windows:
     Download and install [MiKTeX](https://miktex.org/download)

## Installation

1. Clone this repository or download the script:

   ```bash
   git clone https://github.com/yourusername/markdown-mermaid-to-pdf-pipeline.git
   cd markdown-mermaid-to-pdf-pipeline
   ```

## Usage

The script can be used in two ways:

1. **Basic usage** - Output PDF will have the same name as input file:

   ```bash
   node mermaid-to-pdf.js input.md
   ```

   This will create `input.pdf` in the same directory.

2. **Specify output filename** - Choose your own output filename:

   ```bash
   node mermaid-to-pdf.js input.md custom-output.pdf
   ```

### Example Markdown File

Your markdown file should contain Mermaid diagrams in code blocks marked with \`\`\`mermaid:

````markdown
# My Document

Here's a flowchart:

```mermaid
graph TD
    A[Start] --> B{Is it working?}
    B -- Yes --> C[Great!]
    B -- No --> D[Debug]
    D --> B
```
````

## How It Works

The script performs the following steps:

1. Reads the input Markdown file
2. Creates a temporary directory for image files
3. Identifies Mermaid diagram code blocks
4. Converts each Mermaid diagram to a PNG image
5. Replaces Mermaid code blocks with image references
6. Uses Pandoc to convert the processed Markdown to PDF
7. Cleans up temporary files

## Error Handling

The script includes comprehensive error handling:

- Validates input file existence
- Provides clear error messages
- Cleans up temporary files even if an error occurs
- Shows detailed progress feedback

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the LICENSE file for details.
