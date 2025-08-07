#!/usr/bin/env python3
import os
from PIL import Image, ImageDraw, ImageFont
import io

def create_icon():
    """간단한 앱 아이콘 생성"""
    size = 512
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # 배경 원
    draw.ellipse([20, 20, size-20, size-20], fill=(76, 175, 80, 255), outline=(255, 255, 255, 255), width=8)
    
    # 약물 캡슐 모양
    # 왼쪽 캡슐
    draw.ellipse([140, 216, 260, 296], fill=(255, 255, 255, 230))
    # 오른쪽 캡슐
    draw.ellipse([252, 216, 372, 296], fill=(255, 255, 255, 230))
    # 중간 부분
    draw.rectangle([200, 216, 312, 296], fill=(255, 255, 255, 230))
    
    # 십자 표시
    draw.line([180, 236, 220, 276], fill=(76, 175, 80, 255), width=6)
    draw.line([220, 236, 180, 276], fill=(76, 175, 80, 255), width=6)
    
    # 텍스트 (간단한 점으로 표현)
    for i in range(5):
        draw.ellipse([240 + i*8, 380, 248 + i*8, 388], fill=(255, 255, 255, 255))
    
    return img

def create_dmg_background():
    """DMG 배경 이미지 생성"""
    width, height = 540, 380
    img = Image.new('RGB', (width, height), (248, 249, 250))
    draw = ImageDraw.Draw(img)
    
    # 제목
    try:
        font = ImageFont.truetype("/System/Library/Fonts/Arial.ttf", 32)
    except:
        font = ImageFont.load_default()
    
    draw.text((270, 80), "Drug Interaction Checker", fill=(51, 51, 51), anchor="mm", font=font)
    
    # 설명
    try:
        small_font = ImageFont.truetype("/System/Library/Fonts/Arial.ttf", 16)
    except:
        small_font = ImageFont.load_default()
    
    draw.text((270, 120), "Professional drug interaction analysis", fill=(102, 102, 102), anchor="mm", font=small_font)
    
    # 앱 아이콘 위치 표시
    draw.rectangle([130, 180, 258, 308], outline=(204, 204, 204), width=2)
    draw.text((194, 330), "Drag to Applications", fill=(102, 102, 102), anchor="mm", font=small_font)
    
    # Applications 폴더 위치 표시
    draw.rectangle([410, 180, 538, 308], outline=(204, 204, 204), width=2)
    draw.text((474, 330), "Applications", fill=(102, 102, 102), anchor="mm", font=small_font)
    
    return img

def main():
    print("🎨 간단한 앱 아이콘과 DMG 배경 생성 중...")
    
    # 아이콘 생성
    icon = create_icon()
    icon.save("icon.png", "PNG")
    print("✅ icon.png 생성 완료")
    
    # DMG 배경 생성
    background = create_dmg_background()
    background.save("dmg-background.png", "PNG")
    print("✅ dmg-background.png 생성 완료")
    
    # 간단한 icns 파일을 위한 준비
    print("📝 다음 단계:")
    print("1. icon.png를 icon.icns로 변환하세요 (macOS에서만 가능)")
    print("2. 또는 icon.png를 그대로 사용하세요")
    print("3. ./build-app.sh를 실행하여 DMG를 빌드하세요")

if __name__ == "__main__":
    main() 