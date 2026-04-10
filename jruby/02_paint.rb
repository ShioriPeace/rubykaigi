# Step 2: マウスで絵を描く
#
# mouse_x, mouse_y      → 今のマウスの位置
# pmouse_x, pmouse_y    → 1フレーム前のマウスの位置
# mouse_pressed?         → マウスボタンが押されているか
#
# 「前の位置」と「今の位置」を線でつなぐ → なめらかな線になる

require 'propane'

class PaintSketch < Propane::App
  def settings
    size(600, 400)
  end

  def setup
    sketch_title 'Step 2: マウスで絵を描く'
    background(240)          # 最初だけ背景を塗る（drawでは塗らない → 描いた線が残る）
    @hue = 0                 # 色相（色の種類）を管理する変数
    color_mode(HSB, 360, 100, 100)  # 色をHSB（色相・彩度・明度）で指定するモード
  end

  def draw
    if mouse_pressed?
      stroke_weight(3)                          # 線の太さ
      stroke(@hue, 80, 90)                      # 線の色（色相が変わると色が変わる）
      line(pmouse_x, pmouse_y, mouse_x, mouse_y) # 前の位置から今の位置へ線を引く
    end
  end

  # マウスボタンを押した瞬間に呼ばれる
  def mouse_pressed
    @hue = (@hue + 30) % 360  # クリックするたびに色が変わる
  end
end

PaintSketch.new
