# Step 1: 円を描く
#
# Processingの基本3メソッド:
#   settings → ウィンドウサイズを決める
#   setup    → 最初に1回だけ実行される（初期設定）
#   draw     → 毎フレーム実行される（1秒に60回）
#
# ここでは draw で毎回同じ円を描いてるだけなので、
# 見た目は静止画と同じ。

require 'propane'

class CircleSketch < Propane::App
  def settings
    size(400, 400)  # ウィンドウの大きさ（横400px × 縦400px）
  end

  def setup
    sketch_title 'Step 1: 円を描く'
  end

  def draw
    background(30)              # 背景を暗いグレーで塗りつぶす（0=黒, 255=白）
    fill(255)                   # 塗りの色を白にする
    no_stroke                   # 輪郭線なし
    ellipse(200, 200, 150, 150) # 円を描く（x, y, 横幅, 縦幅）
  end
end

CircleSketch.new
