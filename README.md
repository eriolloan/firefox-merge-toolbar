# firefox-merge-toolbar

A collection of UI tweaks to give Firefox a cleaner UI in Linux and MacOS.

## Installing

Run the install script:

```bash
$ chmod +x ./install.sh && ./install.sh
```

It will ask your OS and whether you want to remove the default tabs bar. In this case it is recommended to have an alternative way of displaying your open tabs (i.e. using an extension like Sidebery).

Note that on Linux it expects firefow to be installed as a flatpak.

## Troubleshooting

Each tweak has its own .css file and activated tweaks are imported in `customChrome.css`. To be effective, this scripts adds an import for `customChrome.css` to `userChrome.css` (which is the file firefox looks for for css customization).
Installing themes or other tweaks might overwrite `userChrome.css`. In this case, simply rerun `install.sh`.

## Uninstalling

TODO !
