import serial
import pygame
import ctypes

# ===== SERIAL =====
PORT = "COM4"   # ⚠️ sửa lại đúng cổng của bạn
BAUD = 115200

ser = serial.Serial(PORT, BAUD, timeout=1)

# ===== PYGAME =====
pygame.init()

win_w = 400
win_h = 200

# không viền (overlay)
screen = pygame.display.set_mode((win_w, win_h), pygame.NOFRAME)
pygame.display.set_caption("SMART TEMP MONITOR")

# ===== ĐƯA WINDOW LÊN GÓC PHẢI TRÊN =====
user32 = ctypes.windll.user32
screen_w = user32.GetSystemMetrics(0)

hwnd = pygame.display.get_wm_info()['window']

ctypes.windll.user32.SetWindowPos(
    hwnd,
    -1,                        # luôn topmost
    screen_w - win_w,          # sát phải
    0,                         # sát trên
    0, 0,
    0x0001 | 0x0002
)

# ===== FONT =====
font_big = pygame.font.SysFont("Arial", 40)
font_small = pygame.font.SysFont("Arial", 18)

clock = pygame.time.Clock()

temp = 0
blink = False
timer = 0

running = True
while running:
    # ===== READ SERIAL =====
    if ser.in_waiting:
        try:
            line = ser.readline().decode().strip()
            if "T:" in line:
                temp = float(line.split(",")[0].replace("T:", ""))
        except:
            pass

    # ===== EVENT =====
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # ===== BACKGROUND =====
    screen.fill((15, 15, 15))

    # ===== TEXT =====
    text = font_big.render(f"{temp:.1f} C", True, (255, 255, 255))
    screen.blit(text, (30, 80))

    label = font_small.render("TEMPERATURE", True, (100, 200, 255))
    screen.blit(label, (30, 50))

    # ===== BLINK =====
    timer += 1
    if timer > 15:
        blink = not blink
        timer = 0

    # ===== WARNING BOX (SÁT GÓC PHẢI) =====
    if temp >= 42 and blink:
        box_w = 120
        box_h = 50

        x = win_w - box_w
        y = 0

        # nền
        pygame.draw.rect(screen, (255, 255, 0), (x, y, box_w, box_h), border_radius=10)

        # viền
        pygame.draw.rect(screen, (255, 200, 0), (x, y, box_w, box_h), 3, border_radius=10)

        warn = font_small.render("OVERHEAT!", True, (0, 0, 0))
        screen.blit(warn, (x + 10, y + 15))

    pygame.display.flip()
    clock.tick(30)

pygame.quit()
ser.close()