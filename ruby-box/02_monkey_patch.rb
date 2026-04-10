# Step 2: モンキーパッチの隔離
#
# 実行方法:
#   RUBY_BOX=1 ruby 02_monkey_patch.rb
#
# モンキーパッチ = 既存のクラスにメソッドを追加すること。
# 便利だけど、意図しない副作用が起きることがある。
# Boxを使うと、パッチの影響を閉じ込められる。

puts "=== モンキーパッチ問題のデモ ==="
puts

# 通常のモンキーパッチ（Box無し）
puts "String に shout メソッドを追加する前:"
puts "  'hello'.respond_to?(:shout) = #{'hello'.respond_to?(:shout)}"

class String
  def shout
    upcase + "!!!"
  end
end

puts "追加した後:"
puts "  'hello'.shout = #{'hello'.shout}"
puts "→ 全てのStringに影響する（意図しないところでも使えてしまう）"
puts

puts "=== Boxで隔離する ==="
puts

box = Ruby::Box.new

box.eval(<<~RUBY)
  # このBoxの中でだけ Integer にメソッドを追加
  class Integer
    def emoji
      "✨" * self
    end
  end

  puts "Box内: 3.emoji = \#{3.emoji}"
RUBY

puts
puts "Box外: 3.respond_to?(:emoji) = #{3.respond_to?(:emoji)}"
puts
puts "→ Boxの中のモンキーパッチは、外には漏れない！"
puts
puts "これが Ruby::Box の嬉しさ。"
puts "gemがモンキーパッチしていても、自分のコードに影響しない。"
