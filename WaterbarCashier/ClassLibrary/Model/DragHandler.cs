using CefSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace CashierLibrary.Model
{
    public class DragHandler : IDragHandler
    {
        public bool OnDragEnter(IWebBrowser browserControl, IBrowser browser, IDragData dragData, DragOperationsMask mask)
        {
            return true;
        }

        public void OnDraggableRegionsChanged(IWebBrowser browserControl, IBrowser browser, IList<DraggableRegion> regions)
        {
            throw new NotImplementedException();
        }
    }
}
