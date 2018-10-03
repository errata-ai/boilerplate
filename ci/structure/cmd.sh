# Section 1: Front Matter
#
# The first structure test we run is for our front matter.
#
# We use the Node.js script `frontmatter.js` to define a JSON Schema that we then
# check our front matter against.
errata_print "Installing front matter dependencies ..."

npm install --silent gray-matter # Extract the front matter.
npm install --silent glob        # Find the relevant files.
npm install --silent toml        # Used by `gray-matter`.
npm install --silent ajv         # Validate our schema.
npm install --silent prettyjson  # Nice output.

errata_print "Testing front matter ..."
node $DIR/structure/frontmatter.js $2 $FM_STYLE $FM_DELIM


# Section 2: Markup Style
#
# These tests relate to the structure (i.e., not the actual written content) of
# our markup (Markdown only, for now).
#
# See the `.markdownlint.json` file for more details.
#
# See https://github.com/igorshubovych/markdownlint-cli.
errata_print "Installing & running remark-lint ..."

errata_quiet_cmd "npm install -g remark-cli"

# Install plugins:

# See https://github.com/cirosantilli/markdown-style-guide/
errata_quiet_cmd "npm install -g remark-preset-lint-markdown-style-guide"
# Ensure external links are working
errata_quiet_cmd "npm install -g remark-lint-no-dead-urls"

remark --rc-path="ci/structure/.remarkrc.json" $2

