const fs = require('fs');
const { execSync } = require('child_process');
const path = require('path');

// Parse command line arguments
const args = process.argv.slice(2);
if (args.length === 0) {
    console.error('Usage: node mermaid-to-pdf.js <input-markdown-file> [output-pdf-file]');
    console.error('Example: node mermaid-to-pdf.js input.md output.pdf');
    process.exit(1);
}

const inputFile = args[0];
// If output file is not specified, use input filename with .pdf extension
const outputFile = args[1] || inputFile.replace(/\.[^/.]+$/, '') + '.pdf';

// Validate input file exists
if (!fs.existsSync(inputFile)) {
    console.error(`Error: Input file '${inputFile}' does not exist`);
    process.exit(1);
}

console.log(`Converting '${inputFile}' to '${outputFile}'...`);

try {
    // Create temp directory if it doesn't exist
    const tempDir = path.join(__dirname, 'temp_images');
    if (!fs.existsSync(tempDir)) {
        fs.mkdirSync(tempDir);
        console.log('Created temporary directory for images');
    }

    // Read the markdown file
    const markdown = fs.readFileSync(inputFile, 'utf8');
    console.log('Read input markdown file');

    // Split the content into lines
    const lines = markdown.split('\n');

    // Process the content
    let processedContent = '';
    let inMermaidBlock = false;
    let mermaidContent = '';
    let diagramCount = 0;

    console.log('Processing Mermaid diagrams...');
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
            console.log(`Converting diagram ${diagramCount} to image...`);
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

    console.log(`Found and processed ${diagramCount} Mermaid diagrams`);

    // Write processed content to temporary markdown file
    const tempMdPath = path.join(__dirname, 'temp.md');
    fs.writeFileSync(tempMdPath, processedContent);
    console.log('Created temporary processed markdown file');

    // Convert to PDF
    console.log('Converting to PDF...');
    execSync(`pandoc ${tempMdPath} -o "${outputFile}" --pdf-engine=xelatex`);

    // Clean up
    console.log('Cleaning up temporary files...');
    fs.unlinkSync(tempMdPath);
    fs.rmSync(tempDir, { recursive: true, force: true });

    console.log(`Successfully created PDF: ${outputFile}`);

} catch (error) {
    console.error('An error occurred during conversion:');
    console.error(error.message);
    
    // Attempt to clean up temporary files even if there was an error
    try {
        const tempMdPath = path.join(__dirname, 'temp.md');
        const tempDir = path.join(__dirname, 'temp_images');
        
        if (fs.existsSync(tempMdPath)) {
            fs.unlinkSync(tempMdPath);
        }
        if (fs.existsSync(tempDir)) {
            fs.rmSync(tempDir, { recursive: true, force: true });
        }
    } catch (cleanupError) {
        console.error('Error during cleanup:', cleanupError.message);
    }
    
    process.exit(1);
} 