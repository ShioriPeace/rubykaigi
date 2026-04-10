# Step 4: クリックでパーティクルが飛び散る
#
# Rubyのクラスを使って「粒（Particle）」を管理する。
# クリックするたびに粒が生まれて、重力で落ちて、消えていく。

require 'propane'

class ParticlesSketch < Propane::App
  # 1つの粒を表すクラス
  class Particle
    attr_reader :alive

    def initialize(x, y, app)
      @app = app
      @x = x
      @y = y
      angle = app.random(0, Math::PI * 2)    # ランダムな方向
      speed = app.random(2, 6)                # ランダムな速さ
      @vx = Math.cos(angle) * speed           # x方向の速度
      @vy = Math.sin(angle) * speed           # y方向の速度
      @life = 255                              # 寿命（だんだん薄くなる）
      @size = app.random(5, 15)               # 大きさもランダム
      @color = [app.random(100, 255), app.random(100, 255), app.random(100, 255)]
      @alive = true
    end

    def update
      @x += @vx
      @y += @vy
      @vy += 0.1     # 重力（だんだん下に落ちる）
      @life -= 3      # 寿命が減る
      @alive = false if @life <= 0
    end

    def display
      @app.no_stroke
      @app.fill(@color[0], @color[1], @color[2], @life)  # 寿命に応じて透明に
      @app.ellipse(@x, @y, @size, @size)
    end
  end

  def settings
    size(600, 400)
  end

  def setup
    sketch_title 'Step 4: パーティクル'
    @particles = []    # 粒を入れる配列
  end

  def draw
    background(20)

    # 全部の粒を動かして描く
    @particles.each do |p|
      p.update
      p.display
    end

    # 消えた粒を配列から取り除く
    @particles.reject! { |p| !p.alive }

    # 画面左上に粒の数を表示
    fill(255)
    text_size(14)
    text("particles: #{@particles.size}", 10, 25)
    text("click to add!", 10, 45)
  end

  # クリックした場所から粒を20個生成
  def mouse_pressed
    20.times do
      @particles << Particle.new(mouse_x, mouse_y, self)
    end
  end
end

ParticlesSketch.new
