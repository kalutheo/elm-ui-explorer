
    const tree = `<div>
    <div class="snapshot" id="Success">
        <div class="notification is-success" style="paddingRight:1em;width:80%;">
            <button class="delete">
            </button>
            <span>
                Toast
            </span>
        </div>
    </div>
    <div class="snapshot" id="Warning">
        <div class="notification is-warning" style="paddingRight:1em;width:80%;">
            <button class="delete">
            </button>
            <span>
                Toast
            </span>
        </div>
    </div>
    <div class="snapshot" id="Error">
        <div class="notification is-danger" style="paddingRight:1em;width:80%;">
            <button class="delete">
            </button>
            <span>
                Toast
            </span>
        </div>
    </div>
</div>`;
    test("Atom.Toast.Stories", () => {
      expect(tree).toMatchSnapshot();
    });
    