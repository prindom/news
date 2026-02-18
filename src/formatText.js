/**
 * Format text according to HackerNews formatting rules:
 * 1. Blank lines separate paragraphs
 * 2. Text surrounded by asterisks is italicized (use \* or ** for literal asterisks)
 * 3. Text after a blank line indented by 2+ spaces is reproduced verbatim (code blocks)
 * 4. URLs become links (except in submission text field - controlled by caller)
 * 5. URLs in angle brackets <url> are also linked
 */

/**
 * Escape HTML special characters
 */
function escapeHtml(text) {
    const div = document.createElement('div')
    div.textContent = text
    return div.innerHTML
}

/**
 * Convert URLs to clickable links
 */
function linkifyUrls(text) {
    // First handle URLs in angle brackets <url>
    text = text.replace(
        /<(https?:\/\/[^\s>]+)>/g,
        '<a href="$1" target="_blank" rel="noopener noreferrer" class="underline text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-200">$1</a>'
    )

    // Then handle regular URLs not already in links
    // This regex matches URLs that are not already part of an <a> tag
    text = text.replace(
        /(?<!href=["'])(https?:\/\/[^\s<]+[^\s<.,;:!?'")\]])/g,
        (match) => {
            // Don't linkify if already inside an anchor tag
            return `<a href="${match}" target="_blank" rel="noopener noreferrer" class="underline text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-200">${match}</a>`
        }
    )

    return text
}

/**
 * Convert italic markers (*text*) to HTML italic tags
 * Handle escaped asterisks (\*) and double asterisks (**)
 */
function formatItalics(text) {
    // First, protect escaped asterisks and double asterisks
    // Replace \* with a placeholder
    text = text.replace(/\\\*/g, '___ESCAPED_ASTERISK___')
    // Replace ** with a placeholder
    text = text.replace(/\*\*/g, '___DOUBLE_ASTERISK___')

    // Now handle italic formatting: *text* becomes <i>text</i>
    // Match asterisks that surround text (not at word boundaries only)
    text = text.replace(/\*([^*\n]+)\*/g, '<i>$1</i>')

    // Restore protected asterisks
    text = text.replace(/___ESCAPED_ASTERISK___/g, '*')
    text = text.replace(/___DOUBLE_ASTERISK___/g, '*')

    return text
}

/**
 * Main formatting function
 * @param {string} text - The raw text to format
 * @param {boolean} linkify - Whether to convert URLs to links (false for submission text)
 * @returns {string} HTML-formatted text
 */
export function formatHnText(text, linkify = true) {
    if (!text) return ''

    // Split text into lines
    const lines = text.split('\n')
    const result = []
    let inCodeBlock = false
    let codeBlock = []
    let currentParagraph = []
    let previousLineBlank = false

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i]
        const isBlank = line.trim() === ''
        const isIndented = line.length > 0 && line.match(/^  +/) // 2 or more spaces

        // Check if this starts a code block (blank line followed by indented line)
        if (previousLineBlank && isIndented && !inCodeBlock) {
            // Flush current paragraph
            if (currentParagraph.length > 0) {
                result.push('<p>' + currentParagraph.join(' ') + '</p>')
                currentParagraph = []
            }
            inCodeBlock = true
            codeBlock = [line]
        } else if (inCodeBlock) {
            if (isIndented || isBlank) {
                // Continue code block
                codeBlock.push(line)
            } else {
                // End code block
                const codeContent = codeBlock
                    .map((l) => escapeHtml(l))
                    .join('\n')
                result.push(
                    '<pre class="bg-gray-100 dark:bg-gray-800 p-2 rounded overflow-x-auto my-2"><code>' +
                        codeContent +
                        '</code></pre>'
                )
                inCodeBlock = false
                codeBlock = []

                // Process current line normally
                if (!isBlank) {
                    currentParagraph.push(line)
                }
            }
        } else if (isBlank) {
            // Blank line - end current paragraph
            if (currentParagraph.length > 0) {
                let paragraphText = currentParagraph.join(' ')
                paragraphText = escapeHtml(paragraphText)
                paragraphText = formatItalics(paragraphText)
                if (linkify) {
                    paragraphText = linkifyUrls(paragraphText)
                }
                result.push('<p>' + paragraphText + '</p>')
                currentParagraph = []
            }
        } else {
            // Regular line - add to current paragraph
            currentParagraph.push(line)
        }

        previousLineBlank = isBlank
    }

    // Flush any remaining code block
    if (inCodeBlock && codeBlock.length > 0) {
        const codeContent = codeBlock.map((l) => escapeHtml(l)).join('\n')
        result.push(
            '<pre class="bg-gray-100 dark:bg-gray-800 p-2 rounded overflow-x-auto my-2"><code>' +
                codeContent +
                '</code></pre>'
        )
    }

    // Flush any remaining paragraph
    if (currentParagraph.length > 0) {
        let paragraphText = currentParagraph.join(' ')
        paragraphText = escapeHtml(paragraphText)
        paragraphText = formatItalics(paragraphText)
        if (linkify) {
            paragraphText = linkifyUrls(paragraphText)
        }
        result.push('<p>' + paragraphText + '</p>')
    }

    return result.join('\n')
}
