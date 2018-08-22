
    const tree = `<div>
    <div class="snapshot" id="Default">
        <div class="navbar-menu" id="navMenubd-example">
            <a class="navbar-item ">
                <span>
                    Home
                </span>
            </a>
            <a class="navbar-item ">
                <span>
                    About
                </span>
            </a>
        </div>
    </div>
</div>`;
    test("Molecule.Menu.Stories", () => {
      expect(tree).toMatchSnapshot();
    });
    