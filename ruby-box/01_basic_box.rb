# Step 1: Boxの基本
#
# 実行方法:
#   RUBY_BOX=1 ruby 01_basic_box.rb
#
# Boxの中と外で、定数やクラスの状態が独立していることを確認する。

puts "=== Box の外（メインの世界）==="
puts

# メインの世界で定数を定義
MY_CONSTANT = "メインの値"
puts "MY_CONSTANT = #{MY_CONSTANT}"

# メインの世界でクラスを定義
class Greeter
  def hello
    "こんにちは（メイン）"
  end
end

puts "Greeter#hello = #{Greeter.new.hello}"
puts

puts "=== Box を作る ==="
puts

# Box を作成
box = Ruby::Box.new

# Box の中でコードを実行
box.eval(<<~RUBY)
  MY_CONSTANT = "Boxの中の値"
  puts "Box内の MY_CONSTANT = \#{MY_CONSTANT}"

  class Greeter
    def hello
      "こんにちは（Box）"
    end
  end

  puts "Box内の Greeter#hello = \#{Greeter.new.hello}"
RUBY

puts
puts "=== Box の外に戻る ==="
puts
puts "MY_CONSTANT = #{MY_CONSTANT}"
puts "Greeter#hello = #{Greeter.new.hello}"
puts
puts "→ Boxの中で定義した定数やクラスは、外に影響しない！"
