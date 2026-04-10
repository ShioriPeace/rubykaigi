# ruby.wasm: ブラウザでRubyが動く

**HTMLファイルをブラウザで開くだけ**で、Rubyのコードが動く。
インストール不要。ブラウザさえあればOK。

仕組み: CRubyをWebAssembly（Wasm）にコンパイルしたものがブラウザで動く。
JavaScriptじゃなくてRubyでDOM操作ができる。

---

## Step 0: セットアップ

セットアップ不要！ HTMLファイルをブラウザで開くだけ。

```bash
cd ~/rubykaigi/wasm
```

---

## Step 1: Hello World（01_hello.html）

ブラウザで開いてみよう:

```bash
open 01_hello.html
```

Rubyのコードがブラウザの中で動いて、画面に文字が表示される。
**`<script type="text/ruby">` というのがポイント。** 普通は `text/javascript` だけど、Rubyが動く。

---

## Step 2: ボタンを作る（02_button.html）

ボタンをクリックしたらメッセージが変わる。
DOM操作をRubyで書いてる。

```bash
open 02_button.html
```

`JS.global[:document]` でJavaScriptの `document` にアクセスできる。

---

## Step 3: おみくじ（03_omikuji.html）

JRubyチュートリアルで作ったおみくじの **ブラウザ版**。
Rubyの `.sample` メソッドがブラウザの中で動いてる。

```bash
open 03_omikuji.html
```

---

## Step 4: リアルタイム入力（04_realtime.html）

テキスト入力欄に文字を打つと、リアルタイムで文字数カウントや変換が行われる。

```bash
open 04_realtime.html
```

---

## 注意点

- **初回ロードが遅い**: Wasmバイナリ（数十MB）をダウンロードするので、初回は数秒かかる
- **ネットワーク不可**: `Net::HTTP` 等は使えない
- **スレッド不可**: Thread は使えない
- **ネイティブ拡張gem不可**: pure Ruby の gem のみ
- **ファイルシステム不可**: ローカルファイルの読み書きはできない

これらはブラウザ（WebAssembly）の制限。

---

## ふりかえり

- **ruby.wasm** = CRubyをWebAssemblyにコンパイルしたもの
- `<script type="text/ruby">` でHTMLの中にRubyが書ける
- `JS.global` 経由でJavaScriptのオブジェクトにアクセスできる
- DOM操作、イベントリスナー、UIの更新がRubyで書ける
- ブラウザさえあれば動くので、デモや教育に便利
