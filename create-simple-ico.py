#!/usr/bin/env python3
from PIL import Image, ImageDraw

def create_simple_ico():
    """간단한 .ico 파일 생성"""
    # 256x256 크기로 생성
    size = 256
    img = Image.new('RGB', (size, size), (255, 255, 255))
    draw = ImageDraw.Draw(img)
    
    # 배경 원
    margin = 20
    draw.ellipse([margin, margin, size-margin, size-margin], 
                fill=(76, 175, 80), outline=(255, 255, 255), width=8)
    
    # 약물 캡슐 모양
    capsule_width = 100
    capsule_height = 60
    center_x, center_y = size // 2, size // 2
    
    # 왼쪽 캡슐
    left_x = center_x - capsule_width // 2
    draw.ellipse([left_x, center_y - capsule_height//2, 
                 left_x + capsule_width//2, center_y + capsule_height//2], 
                fill=(255, 255, 255))
    
    # 오른쪽 캡슐
    right_x = center_x + capsule_width // 2
    draw.ellipse([right_x - capsule_width//2, center_y - capsule_height//2, 
                 right_x, center_y + capsule_height//2], 
                fill=(255, 255, 255))
    
    # 중간 부분
    draw.rectangle([left_x + capsule_width//2, center_y - capsule_height//2, 
                   right_x - capsule_width//2, center_y + capsule_height//2], 
                  fill=(255, 255, 255))
    
    # 십자 표시
    cross_size = 30
    draw.line([center_x - cross_size, center_y - cross_size, 
              center_x + cross_size, center_y + cross_size], 
             fill=(76, 175, 80), width=6)
    
    draw.line([center_x + cross_size, center_y - cross_size, 
              center_x - cross_size, center_y + cross_size], 
             fill=(76, 175, 80), width=6)
    
    # ICO 파일로 저장
    img.save("icon.ico", format='ICO')
    print("✅ icon.ico 생성 완료 (256x256)")

if __name__ == "__main__":
    print("🪟 간단한 Windows .ico 아이콘 생성 중...")
    create_simple_ico()
    print("🎉 Windows 빌드 준비 완료!") 