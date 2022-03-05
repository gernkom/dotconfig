# Neovim 配置文件

![效果图](screenshots/with%20rust.png)

# 配置说明

1. 把 ``init.vim`` 文件放置到 ``~/.config/nvim`` 目录下
2. 依照 [``vim-plug 文档``](https://github.com/junegunn/vim-plug#installation) 安装插件管理器
3. 依照 [``coc.nvim 文档``](https://github.com/neoclide/coc.nvim#quick-start) 安装 ``nodejs``
4. 启动 ``nvim``，并输入 ``:PlugInstall`` 安装插件
5. 安装好插件后重启 ``nvim``
6. 输入 ``:CocInstall coc-clangd`` 安装 ``coc-clangd``
7. 输入 ``:CocInstall coc-rust-analyzer`` 安装 ``coc-rust-analyzer``
8. 再次重启 ``nvim`` 并打开一个 ``.c`` 文件，按照提示安装 ``clangd``
9. 完成上一步后重启 ``nvim`` 并打开一个 ``.rs`` 文件，按照提示安装 ``rust-analyzer``
10. 使用 ``rustup`` 工具安装 ``rust-src``：``rustup component add rust-src``
11. 至此，所有配置完成

> Enjoy Neovim :)

# 特别鸣谢

* [neovim](https://github.com/neovim/neovim) neovim本体
* [vim-plug](https://github.com/junegunn/vim-plug) 插件管理器
* [vim-airline](https://github.com/vim-airline/vim-airline) airline美化
* [rust.vim](https://github.com/rust-lang/rust.vim) Rust 代码格式高亮等...
* [gruvbox](https://github.com/morhetz/gruvbox) 配色
* [coc-clangd](https://github.com/clangd/coc-clangd)
* [coc.nvim](https://github.com/neoclide/coc.nvim)
* [clangd](https://clangd.llvm.org/)
* [node.js](https://nodejs.org/en/)
* [coc-rust-analyzer](https://github.com/fannheyward/coc-rust-analyzer)

