#!/usr/bin/env bash

if ! [ $# -eq 1 ]
  then
    echo "Please supply container's camelcase name."
    exit 1
fi

NAME=$1
first=`echo ${NAME}|cut -c1|tr [a-z] [A-Z]`
second=`echo ${NAME}|cut -c2-`
PROPERNAME=${first}${second}

cat <<EOF > ${NAME}.tsx
import * as React from 'react'
import { default as styled } from '../../styled-components'
import {
    ${PROPERNAME}Props,
    ${PROPERNAME}State
} from './${NAME}.props'


class ${PROPERNAME} extends React.Component<
    ${PROPERNAME}Props,
    ${PROPERNAME}State
> {
    constructor(props: ${PROPERNAME}Props) {
        super(props)
        this.state = {}
    }

    render() {
        const classes = 'container-${NAME} ' + this.props.className
        return <div className={classes}>{this.props.children}</div>
    }
}

const Styled${PROPERNAME} = styled(${PROPERNAME})\`\`

export default Styled${PROPERNAME}

EOF

cat <<EOF > ${NAME}.stories.tsx
import { storiesOf } from '@storybook/react'
import * as React from 'react'
import ${PROPERNAME} from './${NAME}'

storiesOf('container/${PROPERNAME}', module)
    .add('default', () => <${PROPERNAME} />)
EOF

cat <<EOF > ${NAME}.props.ts
import { ThemeInterface } from '../../styled-components'

export interface ${PROPERNAME}Props {
    theme?: ThemeInterface
    className?: string
}

export interface ${PROPERNAME}State {
}
EOF