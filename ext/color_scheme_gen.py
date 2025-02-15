""" color_scheme_gen.py - dumbass script for generating color scheme, as the name suggest 

    requirements:
        pywal
        requests
        imagemagick
"""

import os
import tempfile
from pathlib import Path
from types import SimpleNamespace
from typing import Any

import pywal
import requests

templates: Path = Path.cwd() / "refs"

images: dict[str, str] = {
    "Dark": "https://hatsune-miku.has.rocks/r/Default_Reference.png",
    "Mystia": "https://hatsune-miku.has.rocks/r/Mystia_Reference.jpg",
    "MystiaAlternative": "https://hatsune-miku.has.rocks/r/MystiaAlternative_Reference.jpg",
    "TennojiRina": "https://hatsune-miku.has.rocks/r/Rina_Reference.png",
    "KagamineRin": "https://hatsune-miku.has.rocks/r/Rin_Reference.png",
    "HatsuneMiku": "https://hatsune-miku.has.rocks/r/Miku_Reference.webp",
    "YuukaHayase": "https://hatsune-miku.has.rocks/r/Yuuka_Reference.png",
    "FuukaAikiyo": "https://hatsune-miku.has.rocks/r/Fuuka_Reference.png",
    "SorasakiHina": "https://hatsune-miku.has.rocks/r/Hina_Reference.png",
    "OnikataKayoko": "https://hatsune-miku.has.rocks/r/Kayoko_Reference.png",
    "Suigintou": "https://hatsune-miku.has.rocks/r/Suigintou_ReferenceV2.webp",
    "SuigintouAlternative": "https://hatsune-miku.has.rocks/r/Suigintou_Reference.jpg",
    "Hutao": "https://hatsune-miku.has.rocks/r/HuTao_Reference.png",
}

# fuckery
os.environ["PATH"] = (
    "C:/Program Files/ImageMagick-7.1.1-Q16-HDRI/" + os.pathsep + os.environ["PATH"]
)


# flutter code gen (fucked)
def generate_enums(color_schemes: list[str]) -> str:
    """src/lib/utils/enum/leafy_theme_style.dart"""

    output: str = "// This file is autogenerated, do not modify!!! \n\n"

    # Enum
    output += "enum LeafyThemeStyle { @replace_enums } \n\n".replace(
        "@replace_enums", ", ".join(map(lambda it: it.lower(), color_schemes))
    )

    # Const
    for color_name in color_schemes:
        output += f"const String _{color_name.lower()} = '{color_name}'; \n"

    # Convert in Enum
    output += "\nextension LeafyThemeStyleExtensions on LeafyThemeStyle {\n"
    output += "  String localize() { \n"
    output += "    switch (this) {\n"

    for color_name in color_schemes:
        output += f"      case LeafyThemeStyle.{color_name.lower()}: \n"
        output += f"        return _{color_name.lower()}; \n"

    output += "      default:\n"
    output += "        throw Exception('Unknown type'); \n"
    output += "    } \n"
    output += "  }\n"
    output += "}\n"

    # Convert from enum
    output += "\nString stringifyLeafyThemeStyle(LeafyThemeStyle style) {\n"
    output += "  switch (style) {\n"

    for color_name in color_schemes:
        output += f"   case LeafyThemeStyle.{color_name.lower()}: \n"
        output += f"    return _{color_name.lower()}; \n"

    output += "   default:\n"
    output += "    throw Exception('Unknown type'); \n"
    output += "  }\n"
    output += "}\n"

    # Convert from str
    output += "\nLeafyThemeStyle leafyThemeStyleFromString(String str) {\n"
    output += "  switch (str) {\n"

    for color_name in color_schemes:
        output += f"   case _{color_name.lower()}: \n"
        output += f"    return LeafyThemeStyle.{color_name.lower()}; \n"

    output += "   default:\n"
    output += "    throw Exception('Unknown type'); \n"
    output += "  }\n"
    output += "}\n"

    return output


def generate_toggler(color_schemes: list[str]) -> str:
    output: str = (templates / "leafy_theme.template").read_text()

    impl: str = (
        """
static void toggleTheme() {
    switch (_currentStyle) {
@among_us
        
        default:
            throw 'Unknown type';
    }


    sharedPreferences.setString(
        kThemeStyleKey,
        stringifyLeafyThemeStyle(_currentStyle),
        );

    _controller.add(null);
}

    
""".replace(
            "@among_us",
            "\n".join(
                f"      case LeafyThemeStyle.{color_name.lower()}:\n          _currentStyle = LeafyThemeStyle.{list(color_schemes)[(i+1) % len(color_schemes)].lower()};\n          break;"
                for i, color_name in enumerate(color_schemes)
            ),
        )
    )

    return output.replace("@replace_toggle_impl", impl)


def generate_home_creator(color_schemes: list[str]) -> str:
    output: str = (templates / "theme_creator.template").read_text()

    impl: str = "\n".join(
        f"      case LeafyThemeStyle.{color_name.lower()}:\n          return HomeTheme.{color_name.lower()}(child);\n"
        for _, color_name in enumerate(color_schemes)
    )

    return output.replace("@replace_impl", impl)


def _hex_to_argb(css_hex_rgb: str):
    # Remove '#' if present
    if css_hex_rgb.startswith("#"):
        css_hex_rgb = css_hex_rgb[1:]

    # Parse the RGB values
    r = int(css_hex_rgb[0:2], 16)
    g = int(css_hex_rgb[2:4], 16)
    b = int(css_hex_rgb[4:6], 16)

    # Alpha value (fully opaque)
    a = 255

    # Format as hexadecimal ARGB
    hex_argb = "0x{:02X}{:02X}{:02X}{:02X}".format(a, r, g, b)

    return hex_argb


def generate_home_theme(color_schemes: dict[str, Any]) -> str:
    output: str = (templates / "home_theme.template").read_text()

    impl: str = ""

    for color_name, color_data_i in color_schemes.items():
        color_data = SimpleNamespace(**color_data_i)

        for key, value in color_data_i.items():
            if isinstance(value, dict):
                setattr(color_data, key, SimpleNamespace(**value))

        color_data.special.background = "0xff" + color_data.special.background.lstrip(
            "#"
        )
        color_data.special.foreground = "0xff" + color_data.special.foreground.lstrip(
            "#"
        )
        color_data.special.cursor = "0xff" + color_data.special.cursor.lstrip("#")

        for i in range(16):
            setattr(
                color_data.colors,
                f"color{i}",
                "0xff" + getattr(color_data.colors, f"color{i}").lstrip("#"),
            )

        color_data.special.background_dimmer = color_data.special.background

        impl += f"\n\nconst HomeTheme.{color_name.lower()}(Widget child) \n"
        impl += "   : super( "
        impl += f"""        
child: child, 
style: LeafyThemeStyle.{color_name.lower()}, 
leafyColor: const Color({color_data.colors.color2}), 
foregroundColor: const Color({color_data.colors.color7}),
foregroundPressedColor: const Color({color_data.colors.color8}), 
backgroundColor: const Color({color_data.colors.color0}), 
secondaryBackgroundColor: const Color({color_data.colors.color9}), 
textInfoColor: const Color({color_data.colors.color7}), 
dialogPositiveColor: const Color({color_data.colors.color10}), 
dialogNegativeColor: const Color({color_data.colors.color13}), 
separatorColor: const Color({color_data.colors.color1}), 
deleteColor: const Color({color_data.colors.color13}), 
"""

        impl += f"""
bodyText1: const TextStyle(
    fontSize: kBodyText1FontSize,
    color: Color({color_data.colors.color7}),
    ),
    bodyText2: const TextStyle(
    fontSize: kBodyText2FontSize,
    color: Color({color_data.colors.color7}),
    ),
    bodyText3: const TextStyle(
    fontSize: kBodyText3FontSize,
    color: Color({color_data.colors.color7}),
    ),
    bodyText4: const TextStyle(
    fontSize: kBodyText4FontSize,
    color: Color({color_data.colors.color7}),
    ),
    bodyText5: const TextStyle(
    fontSize: kBodyText5FontSize,
    color: Color({color_data.colors.color7}),
    ),
    bodyText6: const TextStyle(
    fontSize: kBodyText6FontSize,
    color: Color({color_data.colors.color7}),
    ),
    defaultRadius: _defaultRadius,
);"""

    return output.replace("@replace_impl", impl)


def main() -> int:
    color_schemes: dict[str, dict[str, Any]] = {}

    temp_folder: Path = Path.cwd() / "_cache"
    temp_folder.mkdir(exist_ok=True)

    for theme_name, theme_reference_url in images.items():
        current_image: Path = temp_folder / theme_reference_url.split("/")[-1]

        if not current_image.exists():
            with requests.Session() as sess:
                with sess.get(theme_reference_url) as res:
                    if not res or res.status_code != 200:
                        print("[Net] Failed to get URL:", theme_reference_url)
                        continue

                    current_image.write_bytes(res.content)

        color_schemes[theme_name] = pywal.colors.get(str(current_image), False)

    # src\lib\utils\enum\leafy_theme_style.dart
    (
        Path.cwd().parent / "src" / "lib" / "utils" / "enum" / "leafy_theme_style.dart"
    ).write_text(generate_enums(color_schemes.keys()))

    # src\lib\resources\theme\leafy_theme.dart
    (
        Path.cwd().parent / "src" / "lib" / "resources" / "theme" / "leafy_theme.dart"
    ).write_text(generate_toggler(color_schemes.keys()))

    # src\lib\resources\theme\theme_creators.dart
    (
        Path.cwd().parent
        / "src"
        / "lib"
        / "resources"
        / "theme"
        / "theme_creators.dart"
    ).write_text(generate_home_creator(color_schemes.keys()))

    # src\lib\resources\theme\home_theme.dart"
    (
        Path.cwd().parent / "src" / "lib" / "resources" / "theme" / "home_theme.dart"
    ).write_text(generate_home_theme(color_schemes))

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
