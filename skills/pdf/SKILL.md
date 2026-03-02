---
name: pdf
description: Use when working with PDFs - splitting into pages, extracting pages, merging, or any PDF manipulation. Triggers on "split PDF", "extract pages", "merge PDFs", "combine PDFs".
allowed-tools: Bash, Read, Write, Glob
---

# PDF Manipulation

This skill covers working with PDF files efficiently.

## Tool Comparison for Splitting PDFs

| Tool | Quality | Notes |
|------|---------|-------|
| **qpdf** | Excellent | Handles shared resources efficiently, small output files |
| **mutool** | Excellent | From mupdf, very efficient |
| **gs** (ghostscript) | Good | More complex syntax, versatile |
| **pdfseparate** | Terrible | Duplicates all resources into each page, creates bloated files |
| **pdftk** | Decent | Older tool, sometimes available |

## Splitting PDFs

### Recommended: qpdf

```bash
# Split into individual pages
# qpdf appends zero-padded page numbers to the output name automatically
qpdf --split-pages input.pdf page-.pdf
# Produces: page-001.pdf, page-002.pdf, etc.

# Or put pages in a subdirectory
mkdir -p pages
qpdf --split-pages input.pdf pages/page-.pdf

# Extract specific page range
qpdf input.pdf --pages . 1-10 -- output.pdf
```

### Alternative: mutool (if available)

```bash
mutool poster -x 1 input.pdf output-page-%d.pdf
```

### Alternative: ghostscript

```bash
# Extract single page
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dFirstPage=5 -dLastPage=5 \
   -sOutputFile=page5.pdf input.pdf

# Split all pages (slower but works everywhere)
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
   -sOutputFile=page-%03d.pdf input.pdf
```

## Why pdfseparate is Bad

`pdfseparate` (from poppler-utils) creates individual page files that are often **larger than the original PDF**. This happens because:

1. PDFs share resources (fonts, images) across pages
2. pdfseparate duplicates ALL shared resources into EVERY page
3. A 2MB PDF can produce 390 pages of 2.8MB each (1GB+ total)

**Never use pdfseparate for splitting PDFs.**

## Merging PDFs

```bash
# qpdf
qpdf --empty --pages file1.pdf file2.pdf file3.pdf -- merged.pdf

# Or with page ranges
qpdf --empty --pages file1.pdf 1-5 file2.pdf 10-20 -- merged.pdf
```

## Extracting Text

```bash
# pdftotext (from poppler-utils)
pdftotext input.pdf output.txt

# With layout preservation
pdftotext -layout input.pdf output.txt
```

## Getting PDF Info

```bash
# Page count and metadata
qpdf --show-npages input.pdf
pdfinfo input.pdf
```

## Reading PDFs in Claude

Claude can read PDFs directly using the Read tool. For large PDFs:

1. Split into individual pages first (using qpdf)
2. Read specific pages as needed
3. The Read tool handles PDF rendering automatically
