#!/bin/sh
cat << EOF
--- header ---
title: Last Update
date: 21 Oct 2016
tags: structural
--- body ---
EOF
echo -n "<p>"
date
echo -n "</p>"
