
    const tree = `<div>
    <div class="snapshot" id="LargePrimary">
        <button class="button is-white" style="backgroundColor:#db7093;color:hsl(0, 0%, 96%);width:14em;">
            Primary
        </button>
    </div>
    <div class="snapshot" id="TinyPrimary">
        <button class="button is-white" style="backgroundColor:#db7093;color:hsl(0, 0%, 96%);width:10em;">
            Primary
        </button>
    </div>
    <div class="snapshot" id="LargeSecondary">
        <button class="button is-white" style="backgroundColor:#ff6347;color:hsl(0, 0%, 96%);width:14em;">
            Secondary
        </button>
    </div>
    <div class="snapshot" id="TinySecondary">
        <button class="button is-white" style="backgroundColor:#ff6347;color:hsl(0, 0%, 96%);width:10em;">
            Secondary
        </button>
    </div>
</div>`;
    test("Atom.Button.Stories", () => {
      expect(tree).toMatchSnapshot();
    });
    