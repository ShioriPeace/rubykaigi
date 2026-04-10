# Step 4: メソッド探索を追いかける
#
# "hello".upcase と書いたとき、
# Rubyは upcase メソッドをどこから見つけてくるのか？

puts "=== String の継承チェーン ==="
puts
puts String.ancestors.inspect
puts
puts "→ Rubyはこの順番でメソッドを探す"
puts "  String → Comparable → Object → Kernel → BasicObject"
puts

puts "=== 自分でクラスを作って確かめる ==="
puts

# 動物クラス
class Animal
  def speak
    "..."
  end
end

# 犬クラス（Animalを継承）
class Dog < Animal
  def speak
    "ワン！"
  end
end

# 柴犬クラス（Dogを継承）
class Shiba < Dog
end

puts "Dog.new.speak  = #{Dog.new.speak}"
puts "Shiba.new.speak = #{Shiba.new.speak}"
puts
puts "→ Shibaには speak がないけど、親のDogから見つかる"
puts

puts "Shiba の継承チェーン:"
puts Shiba.ancestors.inspect
puts

puts "=== どこで定義されたか調べる ==="
puts
method = Shiba.instance_method(:speak)
puts "Shiba#speak は #{method.owner} で定義されている"
puts
puts "→ .owner で「このメソッドはどのクラスに書いてあるか」が分かる"
puts

puts "=== method_missing の仕組み ==="
puts

class MagicBox
  def method_missing(name, *args)
    puts "「#{name}」というメソッドは無いけど、呼ばれたよ！"
  end
end

box = MagicBox.new
box.abracadabra
box.open_sesame
puts
puts "→ 継承チェーンを全部探しても見つからないとき、最後に method_missing が呼ばれる"
