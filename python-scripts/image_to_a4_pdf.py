from PIL import Image
import img2pdf
import os
from pathlib import Path
from sys import argv

# A4 size in points (1 pt = 1/72 inch), at 72 DPI = 595 x 842
# A4 in millimeters for img2pdf
A4_WIDTH_MM = 210
A4_HEIGHT_MM = 297

match (len(argv)):
    case 1:
        raise RuntimeError("Require two parameters, the Path to get the images, and the PDF name.")

    case 2:
        raise RuntimeError("Requir another parameter, the PDF name.")

def preprocess_image(img_path: str, output_dir: str = "processed") -> str:
    """Rotate landscape images, convert to RGB, save to output_dir"""
    os.makedirs(output_dir, exist_ok=True)
    img = Image.open(img_path)
    width, height = img.size

    # # Rotate if landscape
    # if width > height:
    #     img = img.rotate(90, expand=True)

    img = img.convert("RGB")  # Remove alpha/EXIF
    output_path = os.path.join(output_dir, os.path.basename(img_path))
    img.save(output_path, "JPEG")
    return output_path


# List your images here
DIRECTORY = "print(1)"

# p: Path = Path(f"{Path().cwd()}/{DIRECTORY}")
p: Path = Path(argv[1])
w: list[str] = [a for a in p.rglob("*.png")]

processed_paths = [preprocess_image(p) for p in w]

# Generate PDF with A4 size pages and image scaled to fit
layout = img2pdf.get_layout_fun(
    pagesize=(img2pdf.mm_to_pt(A4_WIDTH_MM), img2pdf.mm_to_pt(A4_HEIGHT_MM))
)

with open(argv[2], "wb") as f:
    f.write(
        img2pdf.convert(
            processed_paths,
            layout_fun=layout,
            fit=img2pdf.FitMode.into,  # Scale to fit into A4
        )
    )
