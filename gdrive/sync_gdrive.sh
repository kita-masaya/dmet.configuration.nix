#!/bin/sh
SYNCDIR=/home/tono/gdrive

gdrive update --no-progress 1B_x9igDMlVvrmfuMZf-BuXjsqbSBf3AZ redash_backup.gz
gdrive update --no-progress 1wl_cyHaXHAp1N8CoEAeXmnLURE_mAxfY backup_redash.sh
gdrive update --no-progress 1ig9LDNv9JcMfueXwP5_Uo74r2uXzR7X8 sync_gdrive.sh

wget -q -O "担当地区別売上日報出力.xlsx" 'http://localhost/api/queries/40/results.xlsx?api_key=GrVOMaibBKP7YiYpM4qhXa8Wu1OYltWKsAfilMfj'
wget -q -O "受注伝票枚数月別集計.xlsx" 'http://localhost/api/queries/3/results.xlsx?api_key=GdTbo83zTbMCqXpWWEOZyzALbzjtWKGhrSfcA0wB'
wget -q -O "売上グラフ用データ.csv" 'http://localhost/api/queries/42/results.csv?api_key=ohi1klsJsTCSogacGsSEHPWsqIUuYkvzftgYYxSV'
gdrive update --no-progress 1J9DsD-g-L8e3WX6hA_B7GqDJLqnuNNobMuYNkIv64eU "担当地区別売上日報出力.xlsx"
gdrive update --no-progress 19FEM6apkm5Yf_Rw2mOLIQ0Yr88lP9_rpAUPtNvY3TD4 "受注伝票枚数月別集計.xlsx"
gdrive update --no-progress 1HaV2wncrxRDx_KRwaZL7dMVI4wSfsH8hxtZ6IAphFbs "売上グラフ用データ.csv"
gdrive update --no-progress 1T6PFh0f0w2R4FTqeO5JsovFbDvPv8K_IzQCQ0roLIpE "売上グラフ用データ.csv"

# gdrive sync upload --no-progress --keep-local --delete-extraneous . 1V8OelWmtvDRHxT2RGnOlgW58vv1MozV3
