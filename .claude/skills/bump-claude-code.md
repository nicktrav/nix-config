# Bump claude-code version

Upgrade the claude-code package in `overlays/claude-code.nix` to a new version.

## Steps

1. **Check the latest version** on npm:

   Fetch `https://registry.npmjs.org/@anthropic-ai/claude-code/latest` and read the `version` field.

2. **Update `version`** in `overlays/claude-code.nix`.

3. **Compute the new src hash:**

   ```
   nix-prefetch-url --unpack --type sha256 \
     "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-<VERSION>.tgz"
   nix hash convert --hash-algo sha256 --to sri <HASH_FROM_ABOVE>
   ```

   The `nix-prefetch-url` command prints a nix store path and a base32 hash.
   Convert the base32 hash to SRI format with `nix hash convert`.
   Put the SRI hash in the `hash` field under `fetchzip`.

4. **Regenerate `package-lock.json`:**

   ```
   tmpdir=$(mktemp -d)
   cp -r /nix/store/<STORE_PATH_FROM_STEP_3>/* "$tmpdir/"
   cd "$tmpdir"
   npm install --package-lock-only --ignore-scripts
   cp "$tmpdir/package-lock.json" overlays/pkgs/claude-code/package-lock.json
   ```

   The store path is the unpacked directory printed by `nix-prefetch-url --unpack`
   in step 3.

5. **Compute the new `npmDepsHash`:**

   The `prefetch-npm-deps` tool uses curl internally and needs the Netskope
   proxy CA certs. All three env vars are required:

   ```
   nix shell nixpkgs#prefetch-npm-deps -c sh -c \
     'SSL_CERT_FILE=/etc/nix/macos-keychain.crt \
      CURL_CA_BUNDLE=/etc/nix/macos-keychain.crt \
      NIX_SSL_CERT_FILE=/etc/nix/macos-keychain.crt \
      prefetch-npm-deps overlays/pkgs/claude-code/package-lock.json'
   ```

   Put the resulting hash in `npmDepsHash`.

6. **Build:** `nix run .#build`

7. **Switch:** `nix run .#build-switch`

## SSL troubleshooting

If fetches fail with `SSL peer certificate or SSH remote key was not OK`, the
Nix cert bundle at `/etc/nix/macos-keychain.crt` is probably missing the
Netskope proxy CA. Regenerate it:

```
cat /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt > /tmp/nix-combined-certs.pem
security find-certificate -c "goskope" -a -p /Library/Keychains/System.keychain >> /tmp/nix-combined-certs.pem
sudo cp /tmp/nix-combined-certs.pem /etc/nix/macos-keychain.crt
sudo launchctl kickstart -k system/org.nixos.nix-daemon
```

The file should contain ~152 certs (150 from nss-cacert + 2 Netskope).
Verify with `grep -c "BEGIN CERTIFICATE" /etc/nix/macos-keychain.crt`.
