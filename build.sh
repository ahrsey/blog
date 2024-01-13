#!/bin/bash
#
# Convert blog assets to html files

set -e

TEMPLATES_DIR="./templates"
POSTS_DIR="./posts"
DIST_DIR="./dist"
PUBLIC_DIR="./public"

if [ -z "$(\command -v pandoc)" ]; then
  echo "Expected \`pandoc\` to be installed, but we didn't find it 🤷"
fi

# Build home page
\cp $TEMPLATES_DIR/index.html $DIST_DIR

if ! [ -d $DIST_DIR/posts ]; then
  \mkdir $DIST_DIR/posts
fi

navigation=("")
# Build post pages
for file in "${POSTS_DIR}"/*.md; do
  [ -e "$file" ] || continue
  output=$(\basename "${file}" .md)

  \pandoc --standalone \
    --template="$TEMPLATES_DIR/post.html" \
    "$file" \
    -o "$DIST_DIR/posts/$output.html" # --output

  # href="$(printf "%s" "./posts/$output.html" | \sed 's/\//\\\//g')"

  # Build navigation
  # navigation+="<li><a href=\"$href\">$output<\/a><\/li>"
  navigation+=("test")
done

# Insert navigation into home
# \gsed -i "s/\[\[posts\]\]/${navigation[@]}/" $DIST_DIR/index.html

# Remove public folder in dist and recopy
\rm -fr $DIST_DIR/public
\cp -r $PUBLIC_DIR $DIST_DIR
