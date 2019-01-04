import { Component, Prop } from "@stencil/core";
import SVGInjector from "svg-injector";

@Component({
  tag: "svg-loader"
})
export class SvgLoader {
  @Prop() url: string;
  @Prop() color: string;
  @Prop() width: string;

  imageElement!: HTMLElement;

  updateImage() {
    if (this.imageElement) {
      const newImage = new Image();
      newImage.src = this.url;
      newImage.style.fill = this.color;
      newImage.style.width = this.width + "px";
      while (this.imageElement.firstChild) {
        this.imageElement.removeChild(this.imageElement.firstChild);
      }
      this.imageElement.append(newImage);
      SVGInjector(newImage);
    }
  }
  componentDidLoad() {
    this.updateImage();
  }

  componentDidUpdate() {
    this.updateImage();
  }

  render() {
    return <div ref={el => (this.imageElement = el as HTMLElement)} />;
  }
}
