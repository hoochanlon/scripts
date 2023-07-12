import os
import fitz
import PySimpleGUI as sg

def pdf_to_png(pdf_path, image_path):
    # 从 PDF 路径中提取文件名作为文件夹名称
    pdf_name = os.path.splitext(os.path.basename(pdf_path))[0]
    dir = os.path.join(image_path, pdf_name)
    if not os.path.exists(dir):
        os.makedirs(dir)

    doc = fitz.open(pdf_path)
    for i in range(len(doc)):
        page = doc[i]
        pix = page.get_pixmap()
        imageSavePath = os.path.join(dir, f"{pdf_name}_{i}.png")
        pix.save(imageSavePath)

def convert_to_png(pdf_path, image_path):
    pdf_name = os.path.splitext(os.path.basename(pdf_path))[0]
    pdf_to_png(pdf_path, image_path)
    sg.popup("转换完成!", title="PDF转PNG", font=("Helvetica", 16))

# 创建窗口布局
layout = [
    [sg.Text("将需要转换的PDF选入", font=("Helvetica", 16))],
    [sg.Input(key="-FILE-", enable_events=True), sg.FileBrowse(file_types=(("PDF Files", "*.pdf"),), button_text="浏览")],
    [sg.Button("点击转换", key="-CONVERT-")]
]

# 创建窗口
window = sg.Window("PDF文档转PNG图片", layout)

# 事件循环
while True:
    event, values = window.read()

    if event == sg.WINDOW_CLOSED:
        break
    elif event == "-CONVERT-":
        pdf_path = values["-FILE-"]
        convert_to_png(pdf_path, os.path.expanduser("~/Desktop"))

window.close()
