# Markdown to PDF with Mermaid Diagrams

This repository provides two different approaches for converting Markdown files containing Mermaid diagrams into PDF documents. Choose the approach that best suits your needs based on the comparison below.

## Table of Contents

- [Available Approaches](#available-approaches)
  - [Direct PDF Approach](#1-direct-pdf-approach-recommended)
  - [Node.js/PNG Approach](#2-nodejspng-approach)
- [Comparison](#comparison)
- [Prerequisites](#prerequisites)
  - [For Direct PDF Approach](#for-direct-pdf-approach-recommended)
  - [Additional Requirements for Node.js/PNG Approach](#additional-requirements-for-nodejspng-approach)
- [Quick Start](#quick-start)
- [Contributing](#contributing)
- [License](#license)

## Available Approaches

### 1. [Direct PDF Approach](./direct-pdf-approach/) (Recommended)

A simple process using mermaid-cli directly to convert diagrams to PDF format, now with a convenient shell script.

**Key Features:**

- Simpler implementation
- Better diagram quality (vector-based PDFs)
- Flexible file naming
- Automatic cleanup
- Progress feedback
- Minimal dependencies (no LaTeX required)

### 2. [Node.js/PNG Approach](./node-png-approach/)

A custom Node.js script that converts diagrams to PNG format before generating the PDF.

**Key Features:**

- Detailed progress feedback
- Automatic cleanup of temporary files
- Custom output filename support
- Comprehensive error handling
- Requires LaTeX for PDF generation

## Comparison

| Feature | Direct PDF Approach | Node.js/PNG Approach |
|---------|-------------------|---------------------|
| Ease of Use | ✅ Simple shell script | ⚠️ More complex |
| Image Quality | ✅ Vector-based PDFs | ⚠️ Raster-based PNGs |
| Progress Feedback | ✅ Basic feedback | ✅ Detailed |
| Cleanup | ✅ Automatic | ✅ Automatic |
| Maintenance | ✅ Simple script | ⚠️ Custom Node.js code |
| Output Naming | ✅ Flexible | ✅ Flexible |
| Error Handling | ✅ Basic with messages | ✅ Comprehensive |
| Temporary Files | ✅ Hidden directory | ⚠️ Visible directory |
| Dependencies | ✅ Minimal (no LaTeX) | ⚠️ Requires LaTeX |

## Prerequisites

The required tools depend on which approach you choose:

### For Direct PDF Approach (Recommended)

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

### Additional Requirements for Node.js/PNG Approach

4. **LaTeX** (only needed for Node.js/PNG approach)

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
./mermaid-to-pdf.sh input.md output.pdf
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
