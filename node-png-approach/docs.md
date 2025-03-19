# Markdown to PDF with Mermaid Diagrams

This guide documents the process for converting Markdown files containing Mermaid diagrams to PDF format.

## Prerequisites

### Required Tools

1. **Node.js and npm**

   ```bash
   # Check if Node.js is installed
   node --version

   # If not installed, install via Homebrew
   brew install node
   ```

2. **Mermaid CLI**

   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

3. **Pandoc**

   ```bash
   # Check if Pandoc is installed
   which pandoc

   # If not installed, install via Homebrew
   brew install pandoc
   ```

4. **MacTeX** (for PDF generation)

   ```bash
   brew install --cask mactex
   ```

## Conversion Process

### 1. Create the Conversion Script

Create a file named `mermaid-to-pdf.js` in the `docs` folder with the following content:

```javascript
const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

// Create temp directory if it doesn't exist
const tempDir = path.join(__dirname, 'temp_images');
if (!fs.existsSync(tempDir)) {
    fs.mkdirSync(tempDir);
}

// Read the markdown file
const markdown = fs.readFileSync(path.join(__dirname, 'TECHNICAL_AUDIT_REPORT.md'), 'utf8');

// Split the content into lines
const lines = markdown.split('\n');

// Process the content
let processedContent = '';
let inMermaidBlock = false;
let mermaidContent = '';
let diagramCount = 0;

for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    
    if (line.trim() === '```mermaid') {
        inMermaidBlock = true;
        diagramCount++;
        continue;
    }
    
    if (inMermaidBlock && line.trim() === '```') {
        inMermaidBlock = false;
        // Write mermaid content to file
        const diagramFile = path.join(tempDir, `diagram${diagramCount}.mmd`);
        fs.writeFileSync(diagramFile, mermaidContent);
        
        // Convert to image
        const imageFile = path.join(tempDir, `diagram${diagramCount}.png`);
        execSync(`mmdc -i ${diagramFile} -o ${imageFile}`);
        
        // Add image reference to processed content
        processedContent += `![Diagram ${diagramCount}](temp_images/diagram${diagramCount}.png)\n\n`;
        mermaidContent = '';
        continue;
    }
    
    if (inMermaidBlock) {
        mermaidContent += line + '\n';
    } else {
        processedContent += line + '\n';
    }
}

// Write processed content to temporary markdown file
const tempMdPath = path.join(__dirname, 'temp.md');
fs.writeFileSync(tempMdPath, processedContent);

// Convert to PDF
const outputPdfPath = path.join(__dirname, 'TECHNICAL_AUDIT_REPORT.pdf');
execSync(`pandoc ${tempMdPath} -o ${outputPdfPath} --pdf-engine=xelatex`);

// Clean up
fs.unlinkSync(tempMdPath);
fs.rmSync(tempDir, { recursive: true, force: true });
```

### 2. Run the Conversion

Navigate to the `docs` folder and run the script:

```bash
cd docs
node mermaid-to-pdf.js
```

## How It Works

The conversion script performs the following steps:

1. Creates a temporary directory for storing intermediate files
2. Reads the Markdown file
3. Processes the content line by line:
   - When it finds a Mermaid diagram block (```mermaid), it:
     - Extracts the diagram code
     - Saves it to a temporary .mmd file
     - Converts it to a PNG image using mermaid-cli
     - Replaces the Mermaid code block with an image reference
4. Saves the processed content to a temporary Markdown file
5. Converts the temporary Markdown file to PDF using Pandoc with XeLaTeX
6. Cleans up temporary files and directories

## Output

The script will generate:

- `docs/TECHNICAL_AUDIT_REPORT.pdf` - The final PDF file with properly rendered Mermaid diagrams

## Notes

- The script assumes the input file is named `TECHNICAL_AUDIT_REPORT.md` in the same directory
- The output PDF will be named `TECHNICAL_AUDIT_REPORT.pdf` in the same directory
- All temporary files are automatically cleaned up after the process completes
- The script handles multiple Mermaid diagrams in the same document
- Each diagram is numbered sequentially in the output

## Troubleshooting

If you encounter any issues:

1. Ensure all required tools are properly installed
2. Check that the input Markdown file exists and is named correctly
3. Verify that the Mermaid syntax in your diagrams is valid
4. Make sure you have sufficient disk space for temporary files
5. Check the console output for any error messages

## Customization

To use a different input or output filename, modify the following lines in the script:

```javascript
// Change input file
const markdown = fs.readFileSync(path.join(__dirname, 'YOUR_INPUT_FILE.md'), 'utf8');

// Change output file
const outputPdfPath = path.join(__dirname, 'YOUR_OUTPUT_FILE.pdf');
```
