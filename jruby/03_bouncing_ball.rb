# Step 3: ボールが跳ねるアニメーション
#
# draw は1秒に60回呼ばれる。
# 毎回ボールの位置をちょっとずらす → アニメーションになる。
# 端っこに当たったら方向を反転 → 跳ね返る。

require 'propane'

class BouncingBallSketch < Propane::App
  def settings
    size(600, 400)
  end

  def setup
    sketch_title 'Step 3: ボールが跳ねる'
    @x = 300          # ボールのx座標
    @y = 200          # ボールのy座標
    @speed_x = 4      # x方向の速度
    @speed_y = 3      # y方向の速度
    @size = 40         # ボールの大きさ
  end

  def draw
    background(30)

    # ボールを動かす
    @x += @speed_x
    @y += @speed_y

    # 壁に当たったら跳ね返る
    if @x - @size / 2 < 0 || @x + @size / 2 > width
      @speed_x *= -1   # x方向の速度を反転
    end
    if @y - @size / 2 < 0 || @y + @size / 2 > height
      @speed_y *= -1   # y方向の速度を反転
    end

    # ボールを描く
    fill(100, 200, 255)   # 水色
    no_stroke
    ellipse(@x, @y, @size, @size)
  end
end

BouncingBallSketch.new
