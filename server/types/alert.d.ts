export interface AlertProps {
  show?: boolean;
  isShowButton?: boolean;
  message?: string;
}

export interface AlertEmits {
  (e: 'close'): void;
}
