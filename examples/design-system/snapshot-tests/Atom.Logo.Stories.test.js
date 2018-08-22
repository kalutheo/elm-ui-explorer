
    const tree = `<div>
    <div class="snapshot" id="Default">
        <img alt="Bulma: a modern CSS framework based on Flexbox" height="28" src="http://bulma.io/images/bulma-logo.png" width="112">
    </div>
</div>`;
    test("Atom.Logo.Stories", () => {
      expect(tree).toMatchSnapshot();
    });
    