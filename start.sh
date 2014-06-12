#!/bin/sh
cd `dirname $0`
#exec erl -name gordon@127.0.0.1 -pa $PWD/apps/ebin -boot start_sasl -s foodchain -s reloader
exec erl -name gordon@127.0.0.1 -pa $PWD/apps/ebin -s foodchain -s reloader



