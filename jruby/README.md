# JRuby × Processing チュートリアル

RubyでProcessingのスケッチを書いて動かす。
Processingを触ったことがあれば「あ、これRubyで書けるんだ」ってなるはず。

前提知識は不要。コピペで動かして「お〜」ってなればOK。

## しくみ

```
┌─────────────────────┐
│  あなたが書くコード    │  ← Ruby（読みやすい！）
├─────────────────────┤
│   propane (gem)      │  ← RubyとProcessingをつなぐ
├─────────────────────┤
│ Processing + JVM     │  ← 描画エンジン（もともとJava製）
├─────────────────────┤
│     macOS            │  ← 画面に表示
└─────────────────────┘
```

ProcessingはJavaで作られている → JRubyはJavaの世界とつながっている → だからRubyからProcessingが使える。

---

## Step 0: セットアップ

### 0-1. Javaを入れる

```bash
brew install openjdk@17
```

```bash
sudo ln -sfn $(brew --prefix openjdk@17)/libexec/openjdk.jdk \
  /Library/Java/JavaVirtualMachines/openjdk-17.jdk
```

確認:
```bash
java -version
# "openjdk version 17.x.x" が出ればOK
```

### 0-2. JRubyを入れる

```bash
rbenv install jruby-9.4.14.0
```

このフォルダでだけJRubyを使う:
```bash
cd ~/rubykaigi/jruby
rbenv local jruby-9.4.14.0
```

確認:
```bash
ruby --version
# "jruby 9.4.14.0" が出ればOK
```

### 0-3. propane gemを入れる

```bash
jruby -S gem install propane
```

**これで準備完了！**

---

## Step 1: 円を描く（01_circle.rb）

まずは画面に円を1つ描くだけ。

```bash
jruby 01_circle.rb
```

黒い画面の真ん中に白い円が出る。それだけ。でもこれが全ての基本。

Processing でいう `size()`, `background()`, `ellipse()` がそのまま使える。

---

## Step 2: マウスで絵を描く（02_paint.rb）

マウスを動かすと線が描ける、お絵描きアプリ。

```bash
jruby 02_paint.rb
```

マウスを押しながら動かしてみて。クリックするたびに色が変わる。

Processing の `mouse_x`, `mouse_y`, `mouse_pressed?` が使える。

---

## Step 3: ボールが跳ねる（03_bouncing_ball.rb）

ボールが画面の中を跳ね回るアニメーション。

```bash
jruby 03_bouncing_ball.rb
```

`draw` メソッドが1秒間に60回呼ばれ続ける → だからアニメーションになる。
Processing の基本的な仕組みがこれ。

---

## Step 4: パーティクル（04_particles.rb）

クリックした場所からパーティクル（粒）が飛び散る。

```bash
jruby 04_particles.rb
```

画面をクリックしまくってみて。配列とクラスを使って複数の粒を管理している。
Rubyのクラス構文がそのまま使えるのがJRubyの良いところ。

---

## Step 5: 好きに遊ぶ

ここまでのスケッチを改造してみよう。

- 色を変えてみる（`fill(255, 0, 0)` で赤）
- 大きさを変えてみる
- 図形を変えてみる（`rect` で四角、`triangle` で三角）
- ボールを増やしてみる

Processing のリファレンスがそのまま参考になる: https://processing.org/reference

---

## おまけ: GUIアプリ

JavaにはSwingというGUI部品のセットもある。
ボタンやテキスト入力欄を持つデスクトップアプリも作れる。

```bash
jruby extra_omikuji.rb
jruby extra_memo.rb
```

---

## ふりかえり

- **Processing** = Javaで作られたビジュアルプログラミング環境
- **JRuby** = JavaのVM上で動くRuby
- **propane** = JRubyからProcessingを呼ぶためのgem
- Rubyの書きやすさで、Processingの描画力が使える
- `setup` / `draw` / `mouse_pressed` など、Processingの関数がスネークケースでそのまま使える
