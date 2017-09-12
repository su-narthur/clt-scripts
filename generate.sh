#!/usr/bin/env bash

if ! [ $# -eq 2 ]
  then
    echo "Please supply component's layer and camelcase name."
    exit 1
fi

NAME=$2
first=`echo ${NAME}|cut -c1|tr [a-z] [A-Z]`
second=`echo ${NAME}|cut -c2-`
PROPERNAME=${first}${second}
LAYER=$1

cat <<EOF > ${NAME}.tsx
import * as React from 'react'
import { default as styled, ThemeInterface } from '../../styled-components'

interface ${PROPERNAME}Props {
    theme?: ThemeInterface
    className?: string
}

const ${PROPERNAME}: React.StatelessComponent<${PROPERNAME}Props> = props => {
    const classes = 'uk-form-label ' + props.className
    return <div className={classes}>{props.children}</div>
}

const Styled${PROPERNAME} = styled(${PROPERNAME})\`

\`

export default Styled${PROPERNAME}
EOF

cat <<EOF > ${NAME}.stories.tsx
import { storiesOf } from '@storybook/react'
import * as React from 'react'
import ${PROPERNAME} from './${NAME}'

storiesOf('${LAYER}/${PROPERNAME}', module)
    .add('default', () => <${PROPERNAME} />)
EOF