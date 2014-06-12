#!/bin/sh
cd `dirname $0`
exec erl -name gordon@127.0.0.1 -pa $PWD/apps/foodchain/ebin -boot start_sasl -s foodchain -s reloader



