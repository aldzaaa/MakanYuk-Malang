"""Render the editable UTS report with ReportLab (optional documentation tool)."""
from pathlib import Path
from xml.sax.saxutils import escape
import re

from pypdf import PdfReader
from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER, TA_JUSTIFY
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.utils import ImageReader
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, PageBreak, Image, Table, TableStyle,
    Preformatted,
)

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / 'docs'
OUTPUT = DOCS / 'Laporan_UTS_MakanYuk_Malang_Aldza.pdf'
styles = getSampleStyleSheet()
styles.add(ParagraphStyle(name='BodyReport', fontName='Times-Roman', fontSize=11,
                          leading=16, spaceAfter=10, alignment=TA_JUSTIFY))
styles.add(ParagraphStyle(name='TitleReport', fontName='Helvetica-Bold', fontSize=18,
                          leading=24, textColor=colors.HexColor('#24352F'), spaceAfter=18))
styles.add(ParagraphStyle(name='HeadingReport', fontName='Helvetica-Bold', fontSize=12,
                          leading=17, textColor=colors.HexColor('#24352F'), spaceBefore=12, spaceAfter=10))
styles.add(ParagraphStyle(name='CellReport', fontName='Times-Roman', fontSize=10, leading=13))
styles.add(ParagraphStyle(name='CoverReport', fontName='Times-Roman', fontSize=12,
                          leading=18, spaceAfter=15, alignment=TA_CENTER))
styles.add(ParagraphStyle(name='CodeReport', fontName='Courier', fontSize=8, leading=12,
                          backColor=colors.HexColor('#FFF8F0'), borderPadding=8, spaceAfter=12))


def paragraph(text, style='BodyReport'):
    return Paragraph(escape(text), styles[style])


def picture(label, path, width=210, height=440):
    path = DOCS / path
    iw, ih = ImageReader(str(path)).getSize()
    scale = min(width / iw, height / ih)
    return [Image(str(path), iw * scale, ih * scale), Spacer(1, 8), paragraph(label, 'CellReport')]


def footer(canvas, doc):
    if doc.page == 1:
        return
    canvas.saveState()
    canvas.setStrokeColor(colors.HexColor('#E8D9C5'))
    canvas.line(54, 43, 541, 43)
    canvas.setFont('Helvetica', 8)
    canvas.setFillColor(colors.HexColor('#24352F'))
    canvas.drawString(54, 30, 'MakanYuk Malang | Aldza Salwatul Aisy | 240605110227')
    canvas.drawRightString(541, 30, str(doc.page))
    canvas.restoreState()


def build():
    pages = re.split(r'\n---\s*\n', (DOCS / 'LAPORAN_EDITABLE.md').read_text(encoding='utf-8-sig'))
    story = []
    for page_index, page in enumerate(pages):
        if page_index:
            story.append(PageBreak())
        else:
            story.append(Spacer(1, 35))
        lines = page.strip().splitlines()
        i = 0
        while i < len(lines):
            line = lines[i].strip()
            if not line:
                i += 1
                continue
            if line.startswith('```'):
                code = []
                i += 1
                while i < len(lines) and not lines[i].startswith('```'):
                    code.append(lines[i])
                    i += 1
                story.append(Preformatted('\n'.join(code), styles['CodeReport']))
            elif line.startswith('|'):
                rows = []
                while i < len(lines) and lines[i].strip().startswith('|'):
                    rows.append([paragraph(c.strip(), 'CellReport') for c in lines[i].strip().strip('|').split('|')])
                    i += 1
                table = Table(rows, colWidths=[140, 347], hAlign='LEFT', repeatRows=1)
                table.setStyle(TableStyle([
                    ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#E8D9C5')),
                    ('GRID', (0, 0), (-1, -1), .4, colors.HexColor('#BCC8BD')),
                    ('VALIGN', (0, 0), (-1, -1), 'TOP'),
                    ('LEFTPADDING', (0, 0), (-1, -1), 8),
                    ('RIGHTPADDING', (0, 0), (-1, -1), 8),
                    ('TOPPADDING', (0, 0), (-1, -1), 7),
                    ('BOTTOMPADDING', (0, 0), (-1, -1), 7),
                ]))
                story.extend([table, Spacer(1, 14)])
                continue
            elif line.startswith('!['):
                images = []
                while i < len(lines):
                    match = re.fullmatch(r'!\[(.*?)\]\((.*?)\)', lines[i].strip())
                    if match:
                        images.append(match.groups())
                    elif lines[i].strip():
                        break
                    i += 1
                if len(images) == 2:
                    story.append(Table([[picture(*item) for item in images]], colWidths=[243, 244]))
                else:
                    for item in images:
                        story.extend(picture(*item, width=475, height=270))
                story.append(Spacer(1, 14))
                continue
            elif line.startswith('# '):
                heading = paragraph(line[2:], 'TitleReport')
                if page_index == 0:
                    heading.style = ParagraphStyle(name='CoverTitle', parent=styles['TitleReport'], alignment=TA_CENTER)
                story.append(heading)
            elif line.startswith('##'):
                story.append(paragraph(line.lstrip('# '), 'HeadingReport'))
            else:
                if page_index == 0 and line.startswith('[Logo'):
                    logo = Table([[paragraph('Logo fakultas resmi<br/>Lengkapi sebelum pengumpulan', 'CoverReport')]], colWidths=[150], rowHeights=[100])
                    logo.setStyle(TableStyle([('BOX', (0, 0), (-1, -1), .6, colors.HexColor('#BCC8BD')), ('VALIGN', (0, 0), (-1, -1), 'MIDDLE')]))
                    story.extend([Spacer(1, 18), logo, Spacer(1, 30)])
                else:
                    story.append(paragraph(line, 'CoverReport' if page_index == 0 else 'BodyReport'))
            i += 1
    SimpleDocTemplate(str(OUTPUT), pagesize=(595.28, 841.89), rightMargin=54, leftMargin=54,
                      topMargin=48, bottomMargin=58, title='Laporan UTS MakanYuk Malang',
                      author='Aldza Salwatul Aisy').build(story, onFirstPage=footer, onLaterPages=footer)
    reader = PdfReader(OUTPUT)
    text = '\n'.join(page.extract_text() for page in reader.pages)
    assert len(reader.pages) == 11, 'Periksa pagination laporan setelah perubahan.'
    assert all(len(page.extract_text().strip()) > 100 for page in reader.pages)
    for heading in ['BAB I - PENDAHULUAN', 'BAB II - PEMBAHASAN', 'BAB III - PENUTUP', 'DAFTAR PUSTAKA']:
        assert heading in text, f'Bagian laporan hilang: {heading}'
    print(OUTPUT)


if __name__ == '__main__':
    build()
