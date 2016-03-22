SKBpro CAMT CSV export for Pulse import
=======================================

Thanks to https://github.com/dpocock/camt053-xsl for XSL base

Download all CAMT xml files from your SKB PRO e-bank and run this:

Single XML file:
```
xsltproc camt2csv.xsl pro.skb.net-export.xml > pulse-import.csv
```


Multiple XML files:
```
xsltproc camt2csv.xsl *.xml |sort -r|uniq > pulse-import.csv
```


You'll need MacOS or Linux shell to run this + xsltproc tool.
Piping through sort&uniq will remove duplicated CSV headers in case of multipe files
