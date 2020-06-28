import '../stencil.core';
export declare class SvgLoader {
    url: string;
    color: string;
    width: string;
    imageElement: HTMLElement;
    updateImage(): void;
    componentDidLoad(): void;
    componentDidUpdate(): void;
    render(): JSX.Element;
}
