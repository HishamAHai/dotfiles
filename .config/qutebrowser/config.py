config.load_autoconfig(False)

c.qt.highdpi = True

config.set('content.cookies.accept', 'no-3rdparty', '*://www.porntrex.com/*')

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

config.set('content.cookies.accept', 'all', 'devtools://*')

c.content.fullscreen.overlay_timeout = 0

c.content.headers.accept_language = 'en-US,en;q=0.9'

config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

config.set('content.images', True, 'chrome-devtools://*')

config.set('content.images', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome-devtools://*')

config.set('content.javascript.enabled', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome://*/*')

config.set('content.javascript.enabled', True, 'qute://*/*')

config.set('content.notifications.enabled', True, 'https://web.whatsapp.com')

config.set('content.register_protocol_handler', False, 'https://mail.google.com?extsrc=mailto&url=%25s')

c.content.user_stylesheets = []

c.downloads.position = 'bottom'

c.hints.chars = 'asdfghjkl'

c.input.media_keys = False

c.scrolling.bar = 'never'

c.scrolling.smooth = True

c.statusbar.show = 'in-mode'

c.statusbar.padding = {'bottom': 8, 'left': 8, 'right': 8, 'top': 8}

c.statusbar.widgets = ['keypress', 'url', 'history', 'progress']

c.tabs.background = False

c.tabs.close_mouse_button = 'right'

c.tabs.favicons.scale = 1.0

c.tabs.favicons.show = 'always'

c.tabs.padding = {'bottom': 8, 'left': 8, 'right': 8, 'top': 8}

c.tabs.show = 'switching'

c.tabs.title.format = '{title_sep}{current_title}'

c.tabs.indicator.width = 6

c.url.auto_search = 'schemeless'

c.url.default_page = 'file:///home/hisham/.config/qutebrowser/html/index.html'

c.url.open_base_url = True

c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}', 'aw': 'https://wiki.archlinux.org/index.php?search={}', 'br': 'https://search.brave.com/search?q={}&source=web', 'yt': 'https://www.youtube.com/results?search_query={}', 'go': 'https://www.google.com/search?q={}'}

c.url.start_pages = 'file:///home/hisham/.config/qutebrowser/html/index.html'

c.zoom.default = '150%'

c.colors.completion.odd.bg = '#383838'

c.colors.completion.even.bg = '#212121'

c.colors.completion.category.bg = '#212121'

c.colors.completion.category.border.top = '#212121'

c.colors.completion.category.border.bottom = '#212121'

c.colors.completion.item.selected.bg = '#0f7fcf'

c.colors.completion.item.selected.border.top = '#212121'

c.colors.completion.item.selected.border.bottom = '#212121'

c.colors.completion.match.fg = '#fef26c'

c.colors.completion.scrollbar.fg = '#ffffff'

c.colors.completion.scrollbar.bg = '#212121'

c.colors.contextmenu.menu.bg = '#262626'

c.colors.contextmenu.selected.bg = '#0f7fcf'

c.colors.statusbar.normal.bg = '#121212'

c.colors.statusbar.command.bg = '#121212'

c.colors.statusbar.caret.bg = '#121212'

c.colors.statusbar.url.fg = '#fa2573'

c.colors.statusbar.url.hover.fg = '#fa2573'

c.colors.statusbar.url.warn.fg = '#fef26c'

c.colors.tabs.bar.bg = '#121212'

c.colors.tabs.indicator.start = '#0f7fcf'

c.colors.tabs.indicator.stop = '#0f7fcf'

c.colors.tabs.odd.bg = '#121212'

c.colors.tabs.even.bg = '#121212'

c.colors.tabs.selected.odd.bg = '#121212'

c.colors.tabs.selected.even.bg = '#424242'

c.colors.webpage.darkmode.enabled = False

c.colors.webpage.darkmode.algorithm = 'lightness-cielab'

c.colors.webpage.darkmode.grayscale.images = 0.0

config.bind(',cd', 'download-clear')
config.bind(',m', 'hint links spawn mpv {hint-url}')
config.bind(',td', 'config-cycle content.user_stylesheets $HOME/.config/solarized-everything-css/css/darculized/darculized-all-sites.css ""')
config.bind(',ts', 'config-cycle content.user_stylesheets $HOME/.config/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ""')
config.bind(',v', "spawn 'mpv --cache=yes $(xclip -o -selection clipboard)'")
config.bind('ac', 'fake-key c')
config.bind('af', 'fake-key f')
config.bind('am', 'fake-key m')
config.bind('sb', 'config-cycle statusbar.show in-mode always')
config.bind('sn', 'config-cycle statusbar.show in-mode always ;; config-cycle tabs.show switching always')
config.bind('st', 'config-cycle tabs.show always switching')
