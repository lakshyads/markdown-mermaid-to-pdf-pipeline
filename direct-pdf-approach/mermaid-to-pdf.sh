#!/bin/bash

# Help function to display usage
show_help() {
    echo "Usage: $0 <input-file> [output-file]"
    echo
    echo "Convert a markdown file with Mermaid diagrams to PDF"
    echo
    echo "Arguments:"
    echo "  input-file    Input markdown file"
    echo "  output-file   Optional: Output PDF file (default: input-file with .pdf extension)"
    echo
    echo "Example:"
    echo "  $0 input.md output.pdf"
    echo "  $0 document.md         # Will create document.pdf"
}

# Function to find mmdc command
find_mmdc() {
    # First try the command directly
    if command -v mmdc >/dev/null 2>&1; then
        echo "mmdc"
        return 0
    fi

    # Try common npm global installation paths
    local npm_root
    npm_root=$(npm root -g 2>/dev/null)
    if [ $? -eq 0 ] && [ -n "$npm_root" ]; then
        local mmdc_path="$npm_root/@mermaid-js/mermaid-cli/node_modules/.bin/mmdc"
        if [ -x "$mmdc_path" ]; then
            echo "$mmdc_path"
            return 0
        fi
    fi

    # Try node version manager paths
    local nvm_paths=(
        "$HOME/.nvm/versions/node/*/bin/mmdc"
        "$HOME/.asdf/installs/nodejs/*/bin/mmdc"
        "$HOME/.nodenv/versions/*/bin/mmdc"
    )

    for pattern in "${nvm_paths[@]}"; do
        for path in $pattern; do
            if [ -x "$path" ]; then
                echo "$path"
                return 0
            fi
        done
    done

    return 1
}

# Check if help is requested
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Check if input file is provided
if [ -z "$1" ]; then
    echo "Error: Input file is required"
    show_help
    exit 1
fi

# Set input and output files
input_file="$1"
temp_dir="$(dirname "$input_file")/.temp_$(basename "$input_file" .md)"
preprocessed_file="$temp_dir/preprocessed.md"

# If output file is not provided, use input filename with .pdf extension
if [ -z "$2" ]; then
    output_file="${input_file%.*}.pdf"
else
    output_file="$2"
fi

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found"
    exit 1
fi

# Find mmdc command
MMDC_CMD=$(find_mmdc)
if [ $? -ne 0 ]; then
    echo "Error: Could not find mermaid-cli (mmdc)"
    echo "Please ensure mermaid-cli is installed:"
    echo "  npm install -g @mermaid-js/mermaid-cli"
    echo
    echo "If already installed, try:"
    echo "1. Running 'npm root -g' to find your global npm directory"
    echo "2. Using the full path to mmdc in your npm directory"
    echo "3. If using nvm or another version manager, ensure the correct Node version is active"
    exit 1
fi

echo "Using mermaid-cli at: $MMDC_CMD"

# Create temporary directory
mkdir -p "$temp_dir"

echo "Converting Mermaid diagrams to PDF..."
"$MMDC_CMD" -i "$input_file" --outputFormat=pdf --pdfFit -o "$preprocessed_file"

if [ $? -ne 0 ]; then
    echo "Error: Failed to convert Mermaid diagrams"
    echo "Troubleshooting tips:"
    echo "1. Check if your Mermaid diagrams have valid syntax"
    echo "2. Try running mmdc directly: $MMDC_CMD --version"
    echo "3. Check if Node.js and npm are properly installed"
    rm -rf "$temp_dir"
    exit 1
fi

# Check if pandoc is available
if ! command -v pandoc >/dev/null 2>&1; then
    echo "Error: pandoc is not installed"
    echo "Please install pandoc:"
    echo "  macOS:   brew install pandoc"
    echo "  Linux:   sudo apt-get install pandoc"
    echo "  Windows: Download from https://pandoc.org/installing.html"
    rm -rf "$temp_dir"
    exit 1
fi

echo "Generating final PDF..."
pandoc "$preprocessed_file" -f markdown-implicit_figures -o "$output_file"

if [ $? -ne 0 ]; then
    echo "Error: Failed to generate PDF"
    echo "Troubleshooting tips:"
    echo "1. Check if you have write permissions in the output directory"
    echo "2. Verify that the preprocessed markdown file was created correctly"
    echo "3. Try running pandoc with --verbose flag for more information"
    rm -rf "$temp_dir"
    exit 1
fi

# Cleanup
echo "Cleaning up temporary files..."
rm -rf "$temp_dir"

echo "Successfully created PDF: $output_file" 