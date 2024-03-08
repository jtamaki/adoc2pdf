# adoc2pdf

AsciiDocで記述された仕様書をPDFに変換して出力します。

## Usage

``` yaml
- uses: piyopiyo/adoc2pdf@stable
  with:
    input_dir: {path/to/adocs} #変換する*.adocファイルが配置されたディレクトリ
    output_dir: {path/to/pdfs} #変換された*.pdfファイルを出力するディレクトリ
```

## Supported Platforms

本アクションはWindows(x64)上で動作するセルフホステッドランナーでのみ動作します。
