# Markdown to PDF with Mermaid Diagrams

This repository provides two different approaches for converting Markdown files containing Mermaid diagrams into PDF documents. Choose the approach that best suits your needs based on the comparison below.

## Available Approaches

### 1. [Direct PDF Approach](./direct-pdf-approach/) (Recommended)
A simple, two-step process using mermaid-cli directly to convert diagrams to PDF format.

**Key Features:**
- Simpler implementation
- Better diagram quality (vector-based PDFs)
- Fewer conversion steps
- No custom script maintenance

### 2. [Node.js/PNG Approach](./node-png-approach/)
A custom Node.js script that converts diagrams to PNG format before generating the PDF.

**Key Features:**
- More detailed progress feedback
- Automatic cleanup of temporary files
- Custom output filename support
- Comprehensive error handling

## Comparison

| Feature | Direct PDF Approach | Node.js/PNG Approach |
|---------|-------------------|---------------------|
| Ease of Use | ✅ Simpler, fewer steps | ⚠️ More complex |
| Image Quality | ✅ Vector-based PDFs | ⚠️ Raster-based PNGs |
| Progress Feedback | ⚠️ Basic | ✅ Detailed |
| Cleanup | ⚠️ Manual | ✅ Automatic |
| Maintenance | ✅ No custom code | ⚠️ Custom script |
| Output Naming | ⚠️ Fixed convention | ✅ Flexible |
| Error Handling | ⚠️ Basic | ✅ Comprehensive |

## Prerequisites

Both approaches require the following tools:

1. **Node.js and npm**
   ```bash
   # Check if installed
   node --version
   npm --version
   
   # Install via Homebrew if needed
   brew install node
   ```

2. **Mermaid CLI**
   ```bash
   npm install -g @mermaid-js/mermaid-cli
   ```

3. **Pandoc**
   ```bash
   # macOS
   brew install pandoc
   
   # Linux
   sudo apt-get install pandoc
   
   # Windows
   # Download from pandoc.org
   ```

4. **LaTeX**
   ```bash
   # macOS
   brew install --cask mactex
   
   # Linux
   sudo apt-get install texlive-xetex
   
   # Windows
   # Install MiKTeX
   ```

## Quick Start

### Using Direct PDF Approach (Recommended)
```bash
cd direct-pdf-approach
mmdc -i input.md --outputFormat=pdf --pdfFit -o preprocessed.md
pandoc preprocessed.md -f markdown-implicit_figures -o output.pdf
```

### Using Node.js/PNG Approach
```bash
cd node-png-approach
node mermaid-to-pdf.js input.md output.pdf
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
