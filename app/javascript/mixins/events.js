export const events = controller => {

  Object.assign(controller, {

    emitEvent(name, data = undefined) {
      const event = new CustomEvent(name, { detail: data })
      window.dispatchEvent(event)
    }

  });

}
