#!/bin/sh
SYNCDIR=/home/tono/gdrive
wget -q -O "受注伝票枚数月別集計.xlsx" 'http://localhost/api/queries/3/results.xlsx?api_key=GdTbo83zTbMCqXpWWEOZyzALbzjtWKGhrSfcA0wB'
gdrive sync upload --no-progress --keep-local --delete-extraneous . 1V8OelWmtvDRHxT2RGnOlgW58vv1MozV3

